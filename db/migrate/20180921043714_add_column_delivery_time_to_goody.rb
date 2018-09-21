class AddColumnDeliveryTimeToGoody < ActiveRecord::Migration[5.1]
  def change
  	add_column :goodies, :delivery_time, :datetime
  end
end
