class CreateCampaignGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :campaign_groups do |t|
    	t.references :user, foreign_key: true
    	t.references :campaign, foreign_key: true
    	t.integer :income

      t.timestamps
    end
  end
end
