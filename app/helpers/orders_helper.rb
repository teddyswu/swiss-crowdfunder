module OrdersHelper

  def render_is_paid(campaign_id, goody_id, id, is_paid)
  	if is_paid == false
  		link_to "未付款", campaign_goody_order_path(campaign_id, goody_id, id)
  	else
  		"已付款(<a href=\"/\">取消</a>)".html_safe
  	end
  end

end