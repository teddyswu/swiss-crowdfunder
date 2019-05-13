class RenameColumnAndChangeColumn < ActiveRecord::Migration[5.1]
  def change
  	rename_column :user_profiles, :city, :city_id
  	rename_column :user_profiles, :state, :district_id
  	change_column :user_profiles, :city_id, :integer
  	change_column :user_profiles, :district_id, :integer
  end
end
