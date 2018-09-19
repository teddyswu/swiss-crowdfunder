class CreateCampaignImages < ActiveRecord::Migration[5.1]
  def change
    create_table :campaign_images do |t|
    	t.integer :campaign_id
    	t.string :file
    	t.text	:landing_page
    	t.text	:campaign

      t.timestamps
    end
  end
end
