# Preview all emails at http://localhost:3000/rails/mailers/campaign_mailer
class CampaignMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/campaign_mailer/notify_comment
  def notify_comment
    CampaignMailerMailer.notify_comment
  end

end
