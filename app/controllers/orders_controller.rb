class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:is_paid, :payment_info, :finished, :detail]
  before_action :authenticate_user!, only: [:new, :index, :detail]

  # TODO: Think about proper safety in this method/controller. This
  #       code is for demo purposes only and not for production use
  def create
    @goody = Goody.find(params[:goody_id])
    number = "A" + Date.today.year.to_s + (10_000 + Random.rand(100_000 - 10_000)).to_s
    checknumber = Order.exists?(:number => number)
    while checknumber == true do
      number = "A" + Date.today.year.to_s + (10_000 + Random.rand(100_000 - 10_000)).to_s
      checknumber = Order.exists?(:number => number)
    end
    @order = Order.new(order_params)
    @order.number = number
    @order.goody = @goody
    @order.amount = @goody.price
    @order.quantity = 1
    @order.status = 1
    @order.paid = false
    
    if NewOrderService.new(@order).call
      redirect_to go_pay_order_path(@order.id)#[@goody.campaign, @goody, @order]
    else
      render action: 'new'
    end
  end

  def add_evaluation
    @campaigns_new = Campaign.where(:status => 3).order("updated_at DESC").limit(4)
    @order = Order.find(params[:id])
    @campaign = @order.goody.campaign
    @order.evaluation = params[:order][:evaluation]
    @order.save!
    redirect_to detail_order_path(@order.id)#finished_order_path(params[:id], :s => "evaluation")
  end

  def index
    if params[:status] == "cancel"
      @orders = Order.where(:user_id => current_user.id, :status => 4 ).order(id: :desc).paginate(:page => params[:page], per_page: 10)  
    else
      order_a = Order.where(:user_id => current_user.id, :status => 2).where("expire_date > ?",Date.today).order(id: :desc).map { |order| order.id }
      order_b = Order.where(:user_id => current_user.id, :status => 3 ).order(id: :desc).map { |order| order.id }
      order_ids = order_a + order_b
      @orders = Order.where(:id => order_ids).paginate(:page => params[:page], per_page: 10)
    end
    set_page_title "支持紀錄"
  end

  def detail
    @order = Order.find(params[:id])
    redirect_to new_campaign_goody_order_path(@order.goody.campaign.id, @order.goody_id, :s => "f") if @order.status == 1
    set_page_title "支持紀錄-#{@order.goody.campaign.title}"
  end

  def show
    @goody = Goody.find(params[:goody_id])
  end

  def edit
    @cities = City.normal_state
    if params[:city_id]
      @districts = District.select("id,name").where(:city_id => params[:city_id])
    else
      @districts = District.where(:city_id => 1)
    end
    @order = Order.find(params[:id])
    render :layout => false
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    order.save!
    redirect_to detail_order_path(params[:id])
  end

  def finished
    @order = Order.find(params[:id])
    @campaign = @order.goody.campaign
    @campaigns_new = Campaign.where(:status => 3).order("updated_at DESC").limit(4)
    set_page_description @campaign.claim
    set_page_image @campaign.campaign_image.campaign_path
    set_page_title "#{@campaign.title}-支持成功"
  end

  def is_paid
    File.open("#{Rails.root}/log/is_paid.log", "a+") do |file|
      file.syswrite(%(#{Time.now.iso8601}: #{request.raw_post} \n---------------------------------------------\n\n))
    end
    chksource = OffsitePayments::Integrations::Allpay::Notification.new(request.raw_post)
    order = Order.find(params[:id])
    # price = order.amount.to_i + order.bonus.to_i
    # checkstring = "HashKey=#{OffsitePayments::Integrations::Allpay.hash_key}&"+"CustomField1=&CustomField2=&CustomField3=&CustomField4=&EncryptType=1&MerchantID=#{OffsitePayments::Integrations::Allpay.merchant_id}&MerchantTradeNo=#{order.number}&PaymentDate=#{params[:PaymentDate]}&PaymentType=#{params[:PaymentType]}&PaymentTypeChargeFee=#{params[:PaymentTypeChargeFee]}&RtnCode=#{params[:RtnCode]}&RtnMsg=#{params[:RtnMsg]}&SimulatePaid=#{params[:SimulatePaid]}&StoreID=&TradeAmt=#{price}&TradeDate=#{order.created_at.strftime('%F %H:%M:%S')}&TradeNo=#{params[:TradeNo]}" + "&HashIV=#{OffsitePayments::Integrations::Allpay.hash_iv}"
    # encodestr = URI::encode(checkstring).downcase
    # sha256 = Digest::SHA256.hexdigest(encodestr)
    if chksource.checksum_ok?
      File.open("#{Rails.root}/log/is_paid.log", "a+") do |file|
        file.syswrite(%(#{Time.now.iso8601}: #{params[:RtnCode] == "1"} \n---------------------------------------------\n\n))
      end
      if params[:RtnCode] == "1"
        order.paid = true
        order.trade_no = params[:TradeNo]
        order.payment_date = params[:PaymentDate]
        order.ecpay_payment_type = params[:PaymentType]
        order.payment_type_charge_fee = params[:PaymentTypeChargeFee]
        if order.goody.remaining_quantity != 0
          order.status = 3
        else
          order.status = 4
        end
        order.save!
        CampaignMailer.notify_comment(order.user, order.goody.campaign).deliver_now!
        render plain: "1|OK"
      end
      render plain: "0|付款失敗"
    end
    render plain: "0|驗證失敗"
  end

  def payment_info
    File.open("#{Rails.root}/log/is_paid.log", "a+") do |file|
      file.syswrite(%(#{Time.now.iso8601}: payment_info \n---------------------------------------------\n\n))
      file.syswrite(%(#{Time.now.iso8601}: #{request.raw_post} \n---------------------------------------------\n\n))
    end
    chksource = OffsitePayments::Integrations::Allpay::Notification.new(request.raw_post)
    File.open("#{Rails.root}/log/is_paid.log", "a+") do |file|
      file.syswrite(%(#{Time.now.iso8601}: payment_info \n---------------------------------------------\n\n))
      file.syswrite(%(#{Time.now.iso8601}: #{chksource.checksum_ok?} \n---------------------------------------------\n\n))
      file.syswrite(%(#{Time.now.iso8601}: 1234 \n---------------------------------------------\n\n))
    end
    if chksource.checksum_ok?
      t_no = PayOrderNumber.find(:pay_order_number => params[:MerchantTradeNo])
      order = Order.find_by_number(t_no.original_order_number)
      order.status = 2
      order.bank_code = params[:BankCode] if params[:BankCode].present?
      order.expire_date = params[:ExpireDate]
      order.merchant_trade_no = params[:MerchantTradeNo]
      order.trade_amt = params[:TradeAmt]
      order.trade_date = params[:TradeDate]
      order.vAccount = params[:vAccount] if params[:vAccount].present?
      order.payment_no = params[:PaymentNo] if params[:PaymentNo].present?
      order.save!
      render plain: "1|OK"
    end
    render plain: "0|驗證失敗"
  end

  def go_pay
    @order = Order.find(params[:id])
    number = @order.number + (100 + Random.rand(100 - 10)).to_s
    checknumber = PayOrderNumber.exists?(:pay_order_number => number)
    while checknumber == true do
      number = @order.number + (100 + Random.rand(100 - 10)).to_s
      checknumber = PayOrderNumber.exists?(:pay_order_number => number)
    end 
    pay_order_number = PayOrderNumber.new
    pay_order_number.pay_order_number = number
    pay_order_number.original_order_number = @order.number
    pay_order_number.save!
    @number = number
  end


  def new
    @cities = City.normal_state
    if params[:city_id]
      @districts = District.select("id,name").where(:city_id => params[:city_id])
    else
      @districts = District.where(:city_id => 1)
    end
    @last_order = Order.where(:user_id => current_user.id).last
    @goody = Goody.find(params[:goody_id])
    @order = Order.new
    @order.build_supporter
    set_page_description @goody.campaign.claim
    set_page_image @goody.campaign.campaign_image.campaign_path
    set_page_title "#{@goody.campaign.title}-支持提案"
  end

  def user_info
    @cities = City.normal_state
    @districts = District.select("id,name").where(:city_id => current_user.user_profile.city_id)
    render :layout => false
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:user_id, :agreement, :bonus, :payment_type, :anonymous, :remark, 
      supporter_attributes:
    [:first_name, :last_name, :email, :date_of_birth, :address,
    :postal_code, :country, :city_id, :district_id, :tel, :cell_phone, :anonymous])
  end

end
