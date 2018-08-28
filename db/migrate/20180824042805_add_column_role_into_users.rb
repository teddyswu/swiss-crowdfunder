class AddColumnRoleIntoUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :role, :integer, :after => :last_sign_in_ip
  end
end
