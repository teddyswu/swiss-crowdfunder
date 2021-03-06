class CampaignQasController < ApplicationController

	before_action :set_campaign, only: [:show]

	def show
		@campaign_qa = CampaignQa.new
    @campaign_qas = CampaignQa.where(:campaign_id => @campaign.id) || []
    @campaign_replies = @campaign.parent_comments.order( "created_at Desc" )
    user_id = current_user.present? ? current_user.id : nil
    @is_track = Track.exists?(:user_id => user_id, :campaign_id => @campaign.id )
    set_page_description @campaign.claim
    set_page_image @campaign.campaign_image.campaign_path
    set_page_title "#{@campaign.title}-問與答"
    host = YAML.load_file("config/settings.yml")[:root_host]
    @like_url = host + "/campaigns/" + @campaign.slug
	end
	
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

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find_by(:slug => params[:id])
    end
end
