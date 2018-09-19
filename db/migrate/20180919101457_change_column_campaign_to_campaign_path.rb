class ChangeColumnCampaignToCampaignPath < ActiveRecord::Migration[5.1]
  def change
  	rename_column :campaign_images, :campaign, :campaign_path
  end
end
