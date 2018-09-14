class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :group_edit, :goody]
  before_action :authenticate_user!, only: [:index, :new]

  # GET /campaigns/1
  # GET /campaigns/1.json
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

  def index
    @campaigns = Campaign.where(:user_id => current_user.id)
  end

  def new
    @campaign = Campaign.new
  end

  def edit
    
  end

  def group_edit
    @farmer_lists = User.where(:is_check_farmer => true).map {|user| [user.a_user_profile.name, user.id] }
  end

  def group_create
    @campaign_group = CampaignGroup.new(campaign_groups_params)
    @campaign_group.save!
    id = Campaign.find(params[:campaign_groups][:campaign_id])
    redirect_to group_edit_campaign_path(id.slug)
  end

  def gruop_del
    @gruop = CampaignGroup.find(params[:id])
    id = Campaign.find(@gruop.campaign_id)
    @gruop.destroy
    redirect_to group_edit_campaign_path(id.slug)
  end

  def goody
    @goody = Goody.new
  end

  def goody_create
    @goody = Goody.new(goody_params)
    @goody.save!
    id = Campaign.find(params[:goody][:campaign_id])
    redirect_to goody_campaign_path(id.slug)
  end

  def goody_edit
    @goody = Goody.find(params[:id])
  end

  def goody_update
    @goody = Goody.find(params[:id])
    @goody.update(goody_params)
    @goody.save!
    id = Campaign.find(params[:goody][:campaign_id])
    redirect_to goody_campaign_path(id.slug)
  end

  def goody_del
    @goody = Goody.find(params[:id])
    id = Campaign.find(@goody.campaign_id)
    @goody.destroy
    redirect_to goody_campaign_path(id.slug)
  end

  def update
    @campaign.update(campaign_params)
    @campaign.status = params[:campaign][:status]
    @campaign.save!
    redirect_to campaigns_path
  end

  def create
    @campaign = Campaign.new(campaign_params)
    @campaign.description = ActionView::Base.full_sanitizer.sanitize(params[:campaign][:description_html])
    @campaign.order_success = ActionView::Base.full_sanitizer.sanitize(params[:campaign][:order_success_html])
    @campaign.order_description = ActionView::Base.full_sanitizer.sanitize(params[:campaign][:order_description_html])
    @campaign.user_id = current_user.id
    @campaign.active = true
    @campaign.status = 1
    @campaign.save!
    redirect_to campaigns_path
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
      params.require(:campaign).permit(:claim, :email, :goal, :start_date, :end_date,
      :title, :youtube_url, :twitter_url, :facebook_url, :description_html, :order_description_html, :order_success_html)
    end

    def campaign_groups_params
      params.require(:campaign_groups).permit(:campaign_id, :user_id, :income)
    end

    def goody_params
      params.require(:goody).permit(:campaign_id, :title, :description, :price, :quantity)
    end


end
