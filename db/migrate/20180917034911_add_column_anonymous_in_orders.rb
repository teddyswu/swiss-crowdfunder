class AddColumnAnonymousInOrders < ActiveRecord::Migration[5.1]
  def change
  	add_column :orders, :remark, :text, :after => :user_id
  	add_column :orders, :bonus, :integer, :after => :amount
  	add_column :orders, :anonymous, :boolean, :after => :agreement
  end
end
