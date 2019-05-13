class CreateDistricts < ActiveRecord::Migration[5.1]
  def change
    create_table :districts do |t|
    	t.string :name
    	t.string :zipcode
    	t.integer :city_id
    	t.boolean :enabled

      t.timestamps
    end
  end
end
