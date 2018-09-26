class AddColumnTransactionNum < ActiveRecord::Migration[5.1]
  def change
  	add_column :orders, :trade_no, :string, :after => :number 
  end
end
