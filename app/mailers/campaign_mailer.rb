class CampaignMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.campaign_mailer.notify_comment.subject
  #
  def notify_comment(user, campaign)
  	@campaign = campaign
    mail(:to => user.email, :subject => "您贊助了 #{campaign.title}募資項目")
  end
end
