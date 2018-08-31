class CreateUserProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :user_profiles do |t|
    	t.references :user, foreign_key: true
    	t.integer	:gender
    	t.datetime	:birthday
    	t.text	:address
    	t.string	:tel
    	t.string	:cell_phone
      t.timestamps
    end
  end
end
