class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :group_edit, :goody, :group, :support]
  before_action :authenticate_user!, only: [:index, :new]

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
    @campaign_replies = @campaign.parent_comments.order( "created_at Desc" )
    user_id = current_user.present? ? current_user.id : nil
    @is_track = Track.exists?(:user_id => user_id, :campaign_id => @campaign.id )
  end

  def index
    @campaigns = Campaign.where(:user_id => current_user.id)
  end

  def new
    @campaign = Campaign.new
    @campaign_tags = CampaignTag.all
  end

  def edit
    @campaign_tags = CampaignTag.all
    @campaign_tag_ship = CampaignTagShip.where(:campaign_id => @campaign.id).map {|cts| cts.campaign_tag_id }    
  end

  def group
    @campaign_replies = @campaign.parent_comments.order( "created_at Desc" )
    user_id = current_user.present? ? current_user.id : nil
    @is_track = Track.exists?(:user_id => user_id, :campaign_id => @campaign.id )
  end

  def support
    @campaign_replies = @campaign.parent_comments.order( "created_at Desc" )
    user_id = current_user.present? ? current_user.id : nil
    @is_track = Track.exists?(:user_id => user_id, :campaign_id => @campaign.id )
  end

  def group_edit
    @farmer_group = AUserProfile.where.not(:ps_group => nil).group(:ps_group).map {|profile| [profile.ps_group, profile.ps_group] }
    @farmer_all_lists = params[:group_name].present? ? User.joins(:a_user_profile).where("users.is_check_farmer = true and user_profiles.ps_group = ?", params[:group_name]).map {|user| [user.a_user_profile.name, user.id] } : []
    @farmer_exist_lists = params[:group_name].present? ? @campaign.campaign_groups.map {|group| [group.user.a_user_profile.name, group.user.id] } : []
    @farmer_lists = params[:group_name].present? ? @farmer_all_lists - @farmer_exist_lists : []
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
    # @goody_image = GoodyImage.new(goody_image_params)
    # @goody_image.goody_id = @goody.id
    # @goody_image.save!
    @goody.goody_image.update_urls_success?
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
    # if goody_image_params.present?
    #   @goody_image = GoodyImage.find_or_initialize_by(:goody_id => @goody.id)
    #   @goody_image.update(goody_image_params)
    #   @goody_image.save!
    @goody.goody_image.update_urls_success?
    # end
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
    @campaign.save!
    # @campaign.
    # if campaign_image_params.present?

    #   @campaign_image = CampaignImage.find_or_initialize_by(:campaign_id => @campaign.id)
    #   @campaign_image.update(campaign_image_params)
    #   @campaign_image.save!
    @campaign.campaign_image.update_urls_success?
    # end
    if tag_ids_params.present?
      @campaign_tag_ship = CampaignTagShip.where(:campaign_id => @campaign.id)
      @campaign_tag_ship.destroy_all
      tag_ids_params.each do |ti|
        @campaign_tag_ship = CampaignTagShip.new(:campaign_id => @campaign.id, :campaign_tag_id => ti)
        @campaign_tag_ship.save!
      end
    end
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
    # @campaign_image = CampaignImage.new(campaign_image_params)
    # @campaign_image.campaign_id = @campaign.id
    # @campaign_image.save!
    @campaign.campaign_image.update_urls_success?
    tag_ids_params.each do |ti|
      @campaign_tag_ship = CampaignTagShip.new(:campaign_id => @campaign.id, :campaign_tag_id => ti)
      @campaign_tag_ship.save!
    end
    
    redirect_to campaigns_path
  end

  def list
    @campaign = Campaign.friendly.find(params[:id])
  end

  def qas
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.unscoped.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_params
      params.require(:campaign).permit(:claim, :email, :goal, :start_date, :end_date,
      :title, :youtube_url, :twitter_url, :facebook_url, :status, :risk, :description_html, :order_description_html, :order_success_html, campaign_image_attributes: [:file])
    end

    def campaign_groups_params
      params.require(:campaign_groups).permit(:campaign_id, :user_id, :income)
    end

    def goody_params
      params.require(:goody).permit(:campaign_id, :title, :description, :sort, :price, :quantity, :delivery_time, goody_image_attributes: [:file])
    end

    # def campaign_image_params
    #   params.require(:campaign).permit(campaign_image: :file)
    #   # params.require(:campaign).require(:campaign_image).permit(:file)
    # end

    # def goody_image_params
    #   params.require(:goody).permit(goody_image: :file)
    #   # params.require(:goody).require(:goody_image).permit(:file)
    # end

    def tag_ids_params
      params.require(:tag_ids) if params[:tag_ids].present?
    end
end
