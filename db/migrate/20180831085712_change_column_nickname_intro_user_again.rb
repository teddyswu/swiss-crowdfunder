class ChangeColumnNicknameIntroUserAgain < ActiveRecord::Migration[5.1]
  def change
  	change_column :users, :nickname, :string
  end
end
