class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :goody, :group, :support]
  before_action :authenticate_user!, only: [:index, :new]
  protect_from_forgery with: :null_session

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
    @farmer_group = FarmerProfile.where.not(:ps_group => nil).group(:ps_group).map {|profile| [profile.ps_group, profile.ps_group] }
  end

  def edit
    @campaign_tags = CampaignTag.all
    @campaign_tag_ship = CampaignTagShip.where(:campaign_id => @campaign.id).map {|cts| cts.campaign_tag_id }    
    @farmer_group = FarmerProfile.where.not(:ps_group => nil).group(:ps_group).map {|profile| [profile.ps_group, profile.ps_group] }
  end

  def check_slug
    slug = Campaign.find_by_slug(params[:slug])
    render json: (slug.present? ? true : false)
  end

  def group
    @campaign_replies = @campaign.parent_comments.order( "created_at Desc" )
    user_id = current_user.present? ? current_user.id : nil
    @is_track = Track.exists?(:user_id => user_id, :campaign_id => @campaign.id )
    @agrisc_host = YAML.load_file("config/settings.yml")[:agrisc_host]
    @is_favo = current_user.present? ? FavoFarmer.where(:user_id => current_user.id).map { |user| user.farmer_id } : [0]
  end

  def support
    @campaign_replies = @campaign.parent_comments.order( "created_at Desc" )
    user_id = current_user.present? ? current_user.id : nil
    @is_track = Track.exists?(:user_id => user_id, :campaign_id => @campaign.id )
  end

  def group_edit
    @farmer_group = FarmerProfile.where.not(:ps_group => nil).group(:ps_group).map {|profile| [profile.ps_group, profile.ps_group] }
    @farmer_lists = params[:group_name].present? ? User.joins(:farmer_profile).where("users.is_check_farmer = true and farmer_profiles.ps_group = ?", params[:group_name]).map {|user| [user.farmer_profile.name, user.id] } : []
    # @farmer_exist_lists = params[:group_name].present? ? @campaign.campaign_groups.map {|group| [group.user.farmer_profile.name, group.user.id] } : []
    # @farmer_lists = params[:group_name].present? ? @farmer_all_lists - @farmer_exist_lists : []
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
    user_profile = UserProfile.find_by_user_id(current_user.id)
    user_profile.facebook_url = params[:facebook_url]
    user_profile.save!
    @campaign.campaign_image.update_urls_success?
    if tag_ids_params.present?
      @campaign_tag_ship = CampaignTagShip.where(:campaign_id => @campaign.id)
      @campaign_tag_ship.destroy_all
      tag_ids_params.each do |ti|
        @campaign_tag_ship = CampaignTagShip.new(:campaign_id => @campaign.id, :campaign_tag_id => ti)
        @campaign_tag_ship.save!
      end
    end
    if @campaign.status == 2
      render partial: 'shared/project_finished'
    else
      @campaign_group = CampaignGroup.where(:campaign_id => @campaign.id)
      @campaign_group.destroy_all
      if group_params.present?
        group_params.each do |k, v|
          CampaignGroup.create(:campaign_id => @campaign.id, :user_id => v[:user_id], :income => v[:income] )      
        end
      end
      redirect_to campaigns_path
    end
  end

  def create
    @campaign = Campaign.new(campaign_params)
    @campaign.description = ActionView::Base.full_sanitizer.sanitize(params[:campaign][:description_html])
    @campaign.order_success = ActionView::Base.full_sanitizer.sanitize(params[:campaign][:order_success_html])
    @campaign.order_description = ActionView::Base.full_sanitizer.sanitize(params[:campaign][:order_description_html])
    @campaign.user_id = current_user.id
    @campaign.active = true
    @campaign.is_rate = false
    @campaign.status = 1
    @campaign.start_date = params[:campaign][:start_date].gsub(/[年月]/, '-').gsub("日","")
    @campaign.end_date = params[:campaign][:end_date].gsub(/[年月]/, '-').gsub("日","")
    @campaign.save!
    if params[:facebook_url].present?
      user_profile = UserProfile.find_by_user_id(current_user.id)
      user_profile.facebook_url = params[:facebook_url] 
      user_profile.save!
    end
    @campaign.campaign_image.update_urls_success?
    tag_ids_params.each do |ti|
      @campaign_tag_ship = CampaignTagShip.new(:campaign_id => @campaign.id, :campaign_tag_id => ti)
      @campaign_tag_ship.save!
    end
    if group_params.present?
      group_params.each do |k, v|
        CampaignGroup.create(:campaign_id => @campaign.id, :user_id => v[:user_id], :income => v[:income] )      
      end
    end
    
    redirect_to campaigns_path
  end

  def list
    @campaign = Campaign.find_by(:slug => params[:id])
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

  def rate
    @campaign = Campaign.find_by(:slug => params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find_by(:slug => params[:id])
      redirect_to root_path if (@campaign.status != 3 and current_user.is_admin == false and @campaign.user_id != current_user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_params
      params.require(:campaign).permit(:name, :phone, :self_introduction, :slug, :claim, :email, :goal, :start_date, :end_date,
      :title, :youtube_url, :twitter_url, :status, :risk, :description_html, :order_description_html, :order_success_html, campaign_image_attributes: [:file])
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

    def group_params
      params.require(:campaign_groups) if params[:campaign_groups].present?
    end
end
