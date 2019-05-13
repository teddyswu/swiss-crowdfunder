class RenameColumnAndChangeTwoColumn < ActiveRecord::Migration[5.1]
  def change
  	rename_column :supporters, :city, :city_id
  	rename_column :supporters, :state, :district_id
  	change_column :supporters, :city_id, :integer
  	change_column :supporters, :district_id, :integer
  end
end
