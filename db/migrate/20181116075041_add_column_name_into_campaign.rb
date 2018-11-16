class AddColumnNameIntoCampaign < ActiveRecord::Migration[5.1]
  def change
  	add_column :campaigns, :name, :string
  	add_column :campaigns, :phone, :string
  	add_column :campaigns, :self_introduction, :text
  end
end
