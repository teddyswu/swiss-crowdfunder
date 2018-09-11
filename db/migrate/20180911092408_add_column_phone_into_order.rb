class AddColumnPhoneIntoOrder < ActiveRecord::Migration[5.1]
  def change
  	remove_column :orders, :phone
  	add_column :supporters, :tel, :string
  	add_column :supporters, :cell_phone, :string
  end
end
