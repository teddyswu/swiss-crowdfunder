class AddColumnNicknameIntroUser < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :nickname, :integer, :after => :email
  end
end
