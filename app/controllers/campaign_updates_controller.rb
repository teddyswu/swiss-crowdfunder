class CampaignUpdatesController < ApplicationController

	before_action :set_campaign, only: [:show, :detail]

	def show
		@campaign_update = CampaignUpdate.new
    @campaign_updates = CampaignUpdate.where(:campaign_id => @campaign.id).order(created_at: :desc) || []
    @campaign_replies = @campaign.parent_comments.order( "created_at Desc" )
    user_id = current_user.present? ? current_user.id : nil
    @is_track = Track.exists?(:user_id => user_id, :campaign_id => @campaign.id )
    set_page_description @campaign.claim
    set_page_image @campaign.campaign_image.campaign_path
    set_page_title "#{@campaign.title}-進度更新"
    host = YAML.load_file("config/settings.yml")[:root_host]
    @like_url = host + "/campaigns/" + @campaign.slug
	end

	def create
		@campaign_update = CampaignUpdate.new(campaign_update_params)
		sunm = SendUpdateNoticeMailJob.set(wait: 5.minutes).perform_later
		@campaign_update.delayed_job_id = sunm.job_id
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
		set_page_description ActionView::Base.full_sanitizer.sanitize(@campaign_update.campaign_content)[0,60]
    set_page_image @campaign.campaign_image.campaign_path
    set_page_title "#{@campaign.title}-#{@campaign_update.campaign_title}"
    host = YAML.load_file("config/settings.yml")[:root_host]
    @like_url = host + "/campaigns/" + @campaign.slug
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
      @campaign = Campaign.find_by(:slug => params[:id])
    end
end
