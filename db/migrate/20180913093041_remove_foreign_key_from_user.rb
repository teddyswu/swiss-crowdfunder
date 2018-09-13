class RemoveForeignKeyFromUser < ActiveRecord::Migration[5.1]
  def change
  	remove_foreign_key :campaigns, :users
  	remove_foreign_key :campaign_replies, :users
  	remove_foreign_key :user_profiles, :users
  	remove_foreign_key :tracks, :users
  	remove_foreign_key :campaign_groups, :users
  end
end
