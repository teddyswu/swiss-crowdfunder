class CampaignUpdatesController < ApplicationController

	before_action :set_campaign, only: [:show, :detail]

	def show
		@campaign_update = CampaignUpdate.new
    @campaign_updates = CampaignUpdate.where(:campaign_id => @campaign.id).order(created_at: :desc) || []
    @campaign_replies = @campaign.parent_comments.order( "created_at Desc" )
    user_id = current_user.present? ? current_user.id : nil
    @is_track = Track.exists?(:user_id => user_id, :campaign_id => @campaign.id )
	end

	def create
		@campaign_update = CampaignUpdate.new(campaign_update_params)
		@campaign_update.save!
		id = Campaign.find(params[:campaign_update][:campaign_id]).slug
		redirect_to campaign_path(id)
	end

	def edit
		@campaign_update = CampaignUpdate.find(params[:id])
	end

	def detail
		@campaign_update = CampaignUpdate.find(params[:update_id])
		@campaign_replies = @campaign.parent_comments.order( "created_at Desc" )
	end

	def update
		@campaign_update = CampaignUpdate.find(params[:id])
  	@campaign_update.update(campaign_update_params)
  	render :plain => "修改完成"
	end
	
	def campaign_update_params
    params.require(:campaign_update).permit(:campaign_id, :campaign_title, :campaign_content)
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.unscoped.friendly.find(params[:id])
    end
end
