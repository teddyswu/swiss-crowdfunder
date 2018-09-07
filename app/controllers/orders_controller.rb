class OrdersController < ApplicationController

  before_action :authenticate_user!, only: [:new]

  # TODO: Think about proper safety in this method/controller. This
  #       code is for demo purposes only and not for production use
  def create
    @goody = Goody.find(params[:goody_id])
    number = "A" + Date.today.year.to_s + (1_000 + Random.rand(10_000 - 1_000)).to_s
    checknumber = Order.exists?(:number => number)
    while checknumber == true do
      number = "A" + Date.today.year.to_s + (1_000 + Random.rand(10_000 - 1_000)).to_s
      checknumber = Order.exists?(:number => number)
    end
    @order = Order.new(order_params)
    @order.number = number
    @order.goody = @goody
    @order.amount = @goody.price + params[:bonus].to_i
    @order.payment_type = "ecpay"
    @order.quantity = 1
    @order.paid = false

    if NewOrderService.new(@order).call
      redirect_to [@goody.campaign, @goody, @order]
    else
      render action: 'new'
    end
  end

  def show
    @goody = Goody.find(params[:goody_id])
  end

  def go_pay
  end


  def new
    @goody = Goody.find(params[:goody_id])
    @order = Order.new goody: @goody
    @order.build_supporter
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:user_id, :agreement, supporter_attributes:
    [:first_name, :last_name, :email, :date_of_birth, :address,
    :postal_code, :country, :city, :state])
  end

end
