class CreateSendRefundMails < ActiveRecord::Migration[5.1]
  def change
    create_table :send_refund_mails do |t|
    	t.integer 	:campaign_id
    	t.text			:delayed_job_id
    	t.datetime	:run_at
    	t.boolean		:is_send

      t.timestamps
    end
  end
end
