class AddColumnUserProfileNickname < ActiveRecord::Migration[5.1]
  def change
  	add_column :user_profiles, :nickname, :string, :after => :user_id
  end
end
