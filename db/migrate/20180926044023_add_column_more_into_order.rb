class AddColumnMoreIntoOrder < ActiveRecord::Migration[5.1]
  def change
  	add_column :orders, :payment_date, :string
  	add_column :orders, :ecpay_payment_type, :string
  	add_column :orders, :payment_type_charge_fee, :integer
  end
end
