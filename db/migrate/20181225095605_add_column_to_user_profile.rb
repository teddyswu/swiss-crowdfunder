class AddColumnToUserProfile < ActiveRecord::Migration[5.1]
  def change
  	add_column :user_profiles, :facebook_url, :string, :after => :cell_phone
  	remove_column :campaigns, :facebook_url

  end
end
