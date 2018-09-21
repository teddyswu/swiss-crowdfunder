class ChangeColumnDeliveryTimeToGoody < ActiveRecord::Migration[5.1]
  def change
  	change_column :goodies, :delivery_time, :date
  end
end
