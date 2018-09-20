class CreateGoodyImages < ActiveRecord::Migration[5.1]
  def change
    create_table :goody_images do |t|
    	t.integer :goody_id
    	t.string :file
    	t.text	:cover

      t.timestamps
    end
  end
end
