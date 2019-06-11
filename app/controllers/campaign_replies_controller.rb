class CampaignRepliesController < ApplicationController
	before_action :set_campaign, only: [:show]

	def show
		@campaign_reply = CampaignReply.new
    @campaign_replies = @campaign.parent_comments.order( "created_at Desc" )
    @sub_replies = @campaign.sub_comments
    user_id = current_user.present? ? current_user.id : nil
    @is_track = Track.exists?(:user_id => user_id, :campaign_id => @campaign.id )
    @sponsor_ids = @campaign.orders.map {|order| order.user_id }
    set_page_description @campaign.claim
    set_page_image @campaign.campaign_image.campaign_path
    set_page_title "#{@campaign.title}-留言板"
    host = YAML.load_file("config/settings.yml")[:root_host]
    @like_url = host + "/campaigns/" + @campaign.slug
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
      @campaign = Campaign.find_by(:slug => params[:id])
    end
end
