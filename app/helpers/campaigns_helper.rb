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
    (day - Date.today).to_i > 1 ? "#{(day - Date.today).to_i}天" : "已結束"
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

  def render_status_tag(campaign)
    case campaign.status
    when 1
      "<span class='badge badge-warning'>草稿</span>".html_safe
    when 2
      "<span class='badge badge-warning'>審核中</span>".html_safe
    when 3
      return "<span class='badge badge-primary'>即將啟動</span>".html_safe if campaign.start_date > Date.today
      return "<span class='badge badge-primary'>進行中</span>".html_safe if campaign.start_date < Date.today && campaign.end_date > Date.today
      return "<span class='badge badge-danger'>已結束</span>".html_safe if campaign.end_date < Date.today
    end
  end


  def render_camoaign_block(campaign)
    case campaign.status
    when 1
      render "shared/list/draft", campaign: campaign
    when 2
      render "shared/list/review", campaign: campaign
    when 3
      return render "shared/list/soon", campaign: campaign if campaign.start_date > Date.today
      return render "shared/list/processing", campaign: campaign if campaign.start_date < Date.today && campaign.end_date > Date.today
      return render "shared/list/end", campaign: campaign if campaign.end_date < Date.today
    end
  end

  def render_link_or_div(campaign)
    agrisc_host = YAML.load_file("config/settings.yml")[:agrisc_host]
    case campaign.is_rate
    when true
      "<a class=\"btn btn-sm btn-block btn-outline-primary h-100\" href=\"#{agrisc_host}/campaigns/#{campaign.slug}/rate\">
        <div class=\"h-100 d-flex flex-column justify-content-center\">
          <div class=\"font-weight-bold\">滿意度指數</div>
          <div class=\"my-2\">
            <i class=\"far fa-2x fa-smile\"></i>
          </div>
          <div class=>8.5</div>
        </div>
      </a>".html_safe
    else
      "<div class=\"btn btn-sm btn-block btn-outline-secondary h-100\">
        <div class=\"h-100 d-flex flex-column justify-content-center\">
          <div class=\"font-weight-bold\">滿意度指數</div>
          <div class=\"my-2\">
            <i class=\"far fa-2x fa-meh\"></i>
          </div>
          <div class=>尚未調查</div>
        </div>
      </div>".html_safe
    end
  end

end
