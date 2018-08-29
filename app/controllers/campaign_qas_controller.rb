class CampaignQasController < ApplicationController
	def create
		@campaign_qa = CampaignQa.new(campaign_qa_params)
		@campaign_qa.save!
		id = Campaign.find(params[:campaign_qa][:campaign_id]).slug
		redirect_to campaign_path(id)
	end

	def edit
		@campaign_qa = CampaignQa.find(params[:id])
	end
	def update
		@campaign_qa = CampaignQa.find(params[:id])
  	@campaign_qa.update(campaign_qa_params)
  	render :plain => "修改完成"
	end
	def campaign_qa_params
    params.require(:campaign_qa).permit(:campaign_id, :campaign_question, :campaign_answer)
	end
end
