class ChangeColumnToCampaignReply < ActiveRecord::Migration[5.1]
  def change
  	remove_column :campaign_replies, :reply
  	remove_column :campaign_replies, :reply_user_id
  	add_column :campaign_replies, :parent_id, :integer, :after => :content
  end
end
