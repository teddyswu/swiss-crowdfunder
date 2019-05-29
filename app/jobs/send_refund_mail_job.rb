class SendRefundMailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    srm = SendRefundMail.find_by(:delayed_job_id => self.job_id)
    campaign = Campaign.find(srm.campaign_id)
    campaign.orders.each do |order|
    	order.supporter.email
    end
  end
end
