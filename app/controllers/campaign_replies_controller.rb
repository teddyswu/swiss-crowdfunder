class CampaignRepliesController < ApplicationController
	before_action :set_campaign, only: [:show]

	def show
		@campaign_qa = CampaignQa.new
    @campaign_update = CampaignUpdate.new
    @campaign_reply = CampaignReply.new
    @campaign_qas = CampaignQa.where(:campaign_id => @campaign.id) || []
    @campaign_updates = CampaignUpdate.where(:campaign_id => @campaign.id).order(created_at: :desc) || []
    @campaign_replies = @campaign.parent_comments.order( "created_at Desc" )
    @sub_replies = @campaign.sub_comments
    user_id = current_user.present? ? current_user.id : nil
    @is_track = Track.exists?(:user_id => user_id, :campaign_id => @campaign.id )
	end

	def create
		@campaign_reply = CampaignReply.new(campaign_reply_params)
		@campaign_reply.enabled = true
		@campaign_reply.save!
		id = Campaign.find(params[:campaign_reply][:campaign_id]).slug
	end

	def campaign_reply_params
    params.require(:campaign_reply).permit(:campaign_id, :user_id, :content, :enabled, :parent_id)
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.unscoped.friendly.find(params[:id])
    end
end
