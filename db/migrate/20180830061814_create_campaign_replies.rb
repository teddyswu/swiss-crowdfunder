class CreateCampaignReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :campaign_replies do |t|
    	t.references :campaign, foreign_key: true
    	t.references :user, foreign_key: true
    	t.text	:content
    	t.text	:reply
    	t.integer	:reply_user_id
    	t.boolean :enabled

      t.timestamps
    end
  end
end
