class CampaignTagsController < ApplicationController
	before_action :authenticate_user!

	def show
		@campaign_tag = CampaignTag.find(params[:id])
	end

end
