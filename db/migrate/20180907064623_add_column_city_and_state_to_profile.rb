class AddColumnCityAndStateToProfile < ActiveRecord::Migration[5.1]
  def change
  	add_column :user_profiles, :city, :string, :after => :birthday
  	add_column :user_profiles, :state, :string, :after => :city
  	add_column :user_profiles, :postal_code, :string, :after => :state
    add_column :user_profiles, :country, :string, :after => :postal_code
  end
end
