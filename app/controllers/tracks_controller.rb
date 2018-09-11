class TracksController < ApplicationController
	before_action :authenticate_user!, only: [:index]

	def create
    campaign = Campaign.find_by_slug(params[:campaign])
  	@track = Track.where(:user_id => params[:user_id], :campaign_id => campaign.id)
  	@track.present? ? @track.destroy_all : @track.create
  	render plain: "OK"
	end

	def index
		@tracks = Track.where(:user_id => current_user.id)
	end

	def cancel
  	@track = Track.where(:user_id => params[:user_id], :campaign_id => params[:campaign_id])
  	@track.destroy_all
  	redirect_to tracks_path
	end
end
