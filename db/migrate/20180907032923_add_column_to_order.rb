class AddColumnToOrder < ActiveRecord::Migration[5.1]
  def change
  	add_column :orders, :user_id, :integer, :after => :paid
  	rename_column :user_profiles, :name, :first_name
  	add_column :user_profiles, :last_name, :string, :after => :first_name
  	remove_column :supporters, :date_of_birth
  	add_column :orders, :phone, :string
    add_column :orders, :number, :string, :after => :id
  end
end
