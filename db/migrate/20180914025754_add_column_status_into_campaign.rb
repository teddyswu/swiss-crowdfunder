class AddColumnStatusIntoCampaign < ActiveRecord::Migration[5.1]
  def change
  	add_column :campaigns, :status, :integer, :after => :user_id
  end
end
