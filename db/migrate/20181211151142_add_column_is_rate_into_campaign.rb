class AddColumnIsRateIntoCampaign < ActiveRecord::Migration[5.1]
  def change
  	add_column :campaigns, :is_rate, :boolean, :after => :status
  end
end
