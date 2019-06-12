class SendUpdateNoticeMailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    sunm = CampaignUpdate.find_by(:delayed_job_id => self.job_id)
    campaign = Campaign.find(sunm.campaign_id)
    campaign.orders.is_paid.group("user_id").to_a.each do |order|
    	CampaignMailer.campaign_update(order, order.user, order.goody.campaign, sunm).deliver_now!
    end
    sunm.is_send = true
    sunm.save!
  end
end
