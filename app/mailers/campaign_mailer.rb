class CampaignMailer < ApplicationMailer
	add_template_helper(OrdersHelper)

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.campaign_mailer.notify_comment.subject
  #
  def notify_comment(user, campaign, order)
  	@campaign = campaign
  	@order = order
  	@user = user
    mail(:to => user.email, :subject => "您贊助了 #{campaign.title}募資項目")
  end
end
