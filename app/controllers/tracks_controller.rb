class TracksController < ApplicationController
	before_action :authenticate_user!, only: [:index]
	protect_from_forgery with: :null_session

	def create
    campaign = Campaign.find_by_slug(params[:campaign])
  	@track = Track.where(:user_id => params[:user_id], :campaign_id => campaign.id).order("id DESC")
  	@track.present? ? @track.destroy_all : @track.create
  	render plain: "OK"
	end

	def index
		@tracks = Track.where(:user_id => current_user.id).order("id DESC")
		set_page_title "#追蹤提案"
	end

	def cancel
  	@track = Track.where(:user_id => params[:user_id], :campaign_id => params[:campaign_id])
  	@track.destroy_all
  	redirect_to tracks_path
	end
end
