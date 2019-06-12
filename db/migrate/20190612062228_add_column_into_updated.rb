class AddColumnIntoUpdated < ActiveRecord::Migration[5.1]
  def change
  	add_column :campaign_updates, :delayed_job_id, :text, :after => :user_id
  	add_column :campaign_updates, :is_send, :boolean, :after => :delayed_job_id
  end
end
