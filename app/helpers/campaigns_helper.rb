module CampaignsHelper

  include ToolsLibrary

  def campaign_percentage(campaign)
    number_to_percentage(100*(campaign.amount_raised.to_f / campaign.goal),
                         precision: 1,
                         separator: '.')
    .delete(' ') # In some localizations there's whitespace between the number and the percent
  end

  def is_campaign_active?(campaign)
    campaign.is_active? ? '' : 'disabled'
  end

  def render_remain_day(day)
  	(day - Date.today).to_i > 1 ? (day - Date.today).to_i : "已結束"
  end

  def render_staus(status)
    case status
    when 1
      "草稿"
    when 2
      "審核中"
    when 3
      "審核完成"
    end
      
  end

end
