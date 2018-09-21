class AddColumnSortToGoody < ActiveRecord::Migration[5.1]
  def change
  	add_column :goodies, :sort, :integer, :after => :campaign_id
  end
end
