class CampaignMailer < ApplicationMailer
  add_template_helper(OrdersHelper)

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.campaign_mailer.campaign_success.subject
  #
  def campaign_success(user, campaign, order)
    @campaign = campaign
    @order = order
    mail(:to => user.email, :subject => "友故事｜#{campaign.title} 目標達成通知")
  end

  def campaign_fail(user, campaign, order)
    @campaign = campaign
    @order = order
    mail(:to => user.email, :subject => "友故事｜#{campaign.title} 退款通知")
  end

  def notify_comment(user, campaign, order)
    @campaign = campaign
    @order = order
    @user = user
    mail(:to => user.email, :subject => "友故事｜支持成功確認")
  end

  def campaign_update(order, user, campaign, update)
    @campaign = campaign
    @campaign_update = update
    @order = order
    mail(:to => user.email, :subject => "友故事｜#{campaign.title} 進度更新通知")
  end
end
