class CreateTracks < ActiveRecord::Migration[5.1]
  def change
    create_table :tracks do |t|
    	t.references :user, foreign_key: true
    	t.references :campaign, foreign_key: true
      t.timestamps
    end
  end
end
