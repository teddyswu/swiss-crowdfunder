class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show]

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
    @campaign_qa = CampaignQa.new
    @campaign_qas = CampaignQa.find_by(:campaign_id => @campaign.id) || []
    @campaign_update = CampaignUpdate.new
    @campaign_updates = CampaignUpdate.find_by(:campaign_id => @campaign.id) || []
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.unscoped.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_params
      params.require(:campaign).permit(:goal, :start_date, :end_date,
      :title, :youtube_url, :twitter_url, :facebook_url)
    end
end
