class CampaignUpdatesController < ApplicationController
	def create
		@campaign_update = CampaignUpdate.new(campaign_update_params)
		@campaign_update.save!
		id = Campaign.find(params[:campaign_update][:campaign_id]).slug
		redirect_to campaign_path(id)
	end

	def edit
		@campaign_update = CampaignUpdate.find(params[:id])
	end
	def update
		@campaign_update = CampaignUpdate.find(params[:id])
  	@campaign_update.update(campaign_update_params)
  	render :plain => "修改完成"
	end
	def campaign_update_params
    params.require(:campaign_update).permit(:campaign_id, :campaign_title, :campaign_content)
	end
end
