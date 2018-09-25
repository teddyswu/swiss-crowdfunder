module GoodiesHelper

  def is_goody_active?(goody)
    if (goody.remaining_quantity != 0) and goody.campaign.is_active? and goody.campaign.status == 3 and goody.campaign.start_date > Date.today
      ''
    else
      'disabled'
    end
  end

  def render_quantity(quantity)
  	quantity == -1 ? "∞" : quantity
  end

end
