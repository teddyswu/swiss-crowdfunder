class CampaignRepliesController < ApplicationController
	def create
		@campaign_reply = CampaignReply.new(campaign_reply_params)
		@campaign_reply.enabled = true
		@campaign_reply.save!
		id = Campaign.find(params[:campaign_reply][:campaign_id]).slug
		# redirect_to campaign_path(id)
	end

	# def update
	# 	@campaign_reply = CampaignReply.find(params[:id])
 #  	@campaign_reply.update(campaign_reply_params)
 #  	id = Campaign.find(params[:campaign_reply][:campaign_id]).slug
	# 	redirect_to campaign_path(id)
	# end

	def campaign_reply_params
    params.require(:campaign_reply).permit(:campaign_id, :user_id, :content, :enabled, :parent_id)
	end
end
