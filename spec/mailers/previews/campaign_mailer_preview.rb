# Preview all emails at http://localhost:3000/rails/mailers/campaign_mailer
class CampaignMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/campaign_mailer/campaign_success
  def campaign_success
    CampaignMailerMailer.campaign_success
  end

  def notify_comment
    CampaignMailerMailer.notify_comment
  end

end
