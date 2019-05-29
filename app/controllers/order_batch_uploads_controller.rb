class OrderBatchUploadsController < ApplicationController
	before_action :authenticate_user!
	before_action :check_admin

	def index
		@order = Order.new
	end

	def create
		aa = params[:order][:file]
		CSV.foreach(aa.path, headers: true) do |row|
      order_hash = Hash.new
      order_hash = {
        :quantity => 1 ,
        :amount => row[0],
        :bonus => row[1],
        :payment_type => row[2],
        :paid => true,
        :user_id => row[3],
        :remark => row[4],
        :evaluation => row[5],
        :goody_id => row[6],
        :status => row[7],
        :agreement => 1,
        :anonymous => row[8],
        :ecpay_payment_type => row[9]
      }
      supporter_attributes = Hash.new
      supporter_attributes = {
        :first_name => row[10],
        :email => row[11],
        :address => row[12],
        :postal_code => row[13],
        :country => "TW",
        :city_id => row[14],
        :district_id => row[15],
        :cell_phone => row[16],
      }
      order_hash["supporter_attributes"] = supporter_attributes
      @order = Order.new(order_hash)
      @order.save!
		end
    redirect_to order_batch_uploads_path(:w => "finished")
	end

	def check_admin
    redirect_to root_path if current_user.is_admin != true
  end
end
