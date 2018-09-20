class CreateCampaignTagShips < ActiveRecord::Migration[5.1]
  def change
    create_table :campaign_tag_ships do |t|
    	t.integer :campaign_id
    	t.integer :campaign_tag_id

      t.timestamps
    end
  end
end
