class CreateFavoFarmers < ActiveRecord::Migration[5.1]
  def change
    create_table :favo_farmers do |t|
    	t.integer :user_id
    	t.integer :farmer_id

      t.timestamps
    end
  end
end
