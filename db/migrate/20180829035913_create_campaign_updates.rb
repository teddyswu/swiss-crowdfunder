class CreateCampaignUpdates < ActiveRecord::Migration[5.1]
  def change
    create_table :campaign_updates do |t|
    	t.references :campaign, foreign_key: true
    	t.text	:campaign_title
    	t.text	:campaign_content
    	t.integer	:user_id	

      t.timestamps
    end
  end
end
