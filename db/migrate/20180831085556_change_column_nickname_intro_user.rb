class ChangeColumnNicknameIntroUser < ActiveRecord::Migration[5.1]
  def change
  	change_column :users, :nickname, :text
  end
end
