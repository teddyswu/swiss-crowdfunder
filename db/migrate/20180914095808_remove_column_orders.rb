class RemoveColumnOrders < ActiveRecord::Migration[5.1]
  def change
  	remove_foreign_key :goodies, :campaigns
  end
end
