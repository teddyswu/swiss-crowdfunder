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
  	(day - Date.today).to_i > 1 ? "剩下<strong>#{(day - Date.today).to_i}</strong>天".html_safe : "已結束"
  end

  def render_remain_day_only_num(day)
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

  def campaign_tag(campaign)
    if 100*(campaign.amount_raised.to_f / campaign.goal) > 100
      "<span class='badge badge-danger'>達成</span>".html_safe
    else
      if (Date.today - campaign.start_date) < 7
        "<span class='badge badge-primary'>NEW</span>".html_safe
      else
        if (campaign.end_date - Date.today).to_i < 1
          "<span class='badge badge-warning'>結束</span>".html_safe
        end
      end
    end
  end

end
