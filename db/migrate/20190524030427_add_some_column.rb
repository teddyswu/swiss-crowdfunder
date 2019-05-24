class AddSomeColumn < ActiveRecord::Migration[5.1]
  def change
  	add_column :orders, :status, :integer, :after => :goody_id
  	add_column :orders, :rtn_code, :string, :after => :anonymous
  	add_column :orders, :bank_code, :string, :after => :rtn_code
  	add_column :orders, :expire_date, :string, :after => :bank_code
  	add_column :orders, :merchant_trade_no, :string, :after => :expire_date
  	add_column :orders, :trade_amt, :string, :after => :merchant_trade_no
  	add_column :orders, :trade_date, :string, :after => :trade_amt
  	add_column :orders, :vAccount, :string, :after => :bank_code
  	add_column :orders, :payment_no, :string, :after => :trade_no
  	add_column :campaigns, :result_status, :integer, :after => :status
  	add_column :campaigns, :is_send, :boolean, :after => :is_rate
  end
end
