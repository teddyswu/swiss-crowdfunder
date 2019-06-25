class AddAgeRangeIntoUserProfile < ActiveRecord::Migration[5.1]
  def change
  	add_column :user_profiles, :age_range, :integer, :after => :birthday
  end
end
