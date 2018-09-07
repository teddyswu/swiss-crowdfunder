class AddColumnStreetToAddress < ActiveRecord::Migration[5.1]
  def change
  	rename_column :supporters, :street, :address
  end
end
