class CreatePayOrderNumbers < ActiveRecord::Migration[5.1]
  def change
    create_table :pay_order_numbers do |t|
    	t.string :pay_order_number
    	t.string :original_order_number

      t.timestamps
    end
  end
end
