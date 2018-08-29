class CreateCampaignQas < ActiveRecord::Migration[5.1]
  def change
    create_table :campaign_qas do |t|
    	t.references :campaign, foreign_key: true
    	t.text	:campaign_question
      t.text	:campaign_answer
      t.timestamps
    end
  end
end
