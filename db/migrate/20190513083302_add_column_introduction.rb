class AddColumnIntroduction < ActiveRecord::Migration[5.1]
  def change
  	add_column :user_profiles, :introduction, :text, :after => :facebook_url
  end
end
