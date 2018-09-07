class AddColumnNameIntorProfile < ActiveRecord::Migration[5.1]
  def change
  	add_column :user_profiles, :name, :string, :after => :user_id
  end
end
