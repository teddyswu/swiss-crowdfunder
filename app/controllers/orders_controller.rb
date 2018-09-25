class OrdersController < ApplicationController

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

  def index
    @orders = Order.where(:user_id => current_user.id)
  end

  def show
    @goody = Goody.find(params[:goody_id])
  end

  def finished
    
  end

  def go_pay
    @order = Order.find(params[:id])
  end


  def new
    @goody = Goody.find(params[:goody_id])
    @order = Order.new goody: @goody
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
