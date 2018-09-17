class AddColumnRiskInCampaigns < ActiveRecord::Migration[5.1]
  def change
  	add_column :campaigns, :risk, :text, :after => :updated_at
  end
end
