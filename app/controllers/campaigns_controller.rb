class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show]
  before_action :authenticate_user!, only: [:index]

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
    @campaign_qa = CampaignQa.new
    @campaign_update = CampaignUpdate.new
    @campaign_reply = CampaignReply.new
    @campaign_qas = CampaignQa.where(:campaign_id => @campaign.id) || []
    @campaign_updates = CampaignUpdate.where(:campaign_id => @campaign.id).order(created_at: :desc) || []
    @campaign_replies = CampaignReply.where(:campaign_id => @campaign.id) || []
    user_id = current_user.present? ? current_user.id : nil
    @is_track = Track.exists?(:user_id => user_id, :campaign_id => @campaign.id )
  end

  def index
    @campaigns = Campaign.where(:user_id => current_user.id)
  end

  def list
    @campaign = Campaign.friendly.find(params[:id])
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
