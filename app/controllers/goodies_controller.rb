class GoodiesController < ApplicationController
  before_action :set_goodies, only: [:index]

  def index
  	set_page_description @campaign.claim
    set_page_image @campaign.campaign_image.campaign_path
    set_page_title "#{@campaign.title}-回饋項目"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goodies
      @campaign = Campaign.find_by(:slug => params[:campaign_id])
      @goodies  = @campaign.goodies
    end
end
