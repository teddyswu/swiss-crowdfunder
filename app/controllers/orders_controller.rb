class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:is_paid]
  before_action :authenticate_user!, only: [:new, :index]

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
    @order.paid = false

    if NewOrderService.new(@order).call
      redirect_to go_pay_order_path(@order.id)#[@goody.campaign, @goody, @order]
    else
      render action: 'new'
    end
  end

  def add_evaluation
    @order = Order.find(params[:id])
    @order.evaluation = params[:order][:evaluation]
    @order.save!
    redirect_to finished_order_path(params[:id], :s => "evaluation")
  end

  def index
    @orders = Order.where(:user_id => current_user.id)
  end

  def show
    @goody = Goody.find(params[:goody_id])
  end

  def finished
    @order = Order.find(params[:id])
    @campaign = @order.goody.campaign
    @campaigns_new = Campaign.where(:status => 3).order("updated_at DESC").limit(4)
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
      if params[:RtnCode] == "1" #&& params[:SimulatePaid] == 0
        order.paid = true
        order.trade_no = params[:TradeNo]
        order.payment_date = params[:PaymentDate]
        order.ecpay_payment_type = params[:PaymentType]
        order.payment_type_charge_fee = params[:PaymentTypeChargeFee]
        order.save!
        CampaignMailer.notify_comment(order.user, order.goody.campaign).deliver_now!
        render plain: "1|OK"
      end
      render plain: "0|付款失敗"
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
    @last_order = Order.where(:user_id => current_user.id).last
    @goody = Goody.find(params[:goody_id])
    @order = Order.new
    @order.build_supporter
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:user_id, :agreement, :bonus, :payment_type, :anonymous, :remark, 
      supporter_attributes:
    [:first_name, :last_name, :email, :date_of_birth, :address,
    :postal_code, :country, :city, :state, :tel, :cell_phone, :anonymous])
  end

end
