class FavoFarmersController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :authenticate_user!, only: [:index, :create]
	def index
		@favo_farmers = FavoFarmer.where(:user_id =>current_user.id)	
		set_page_title "最愛小農"
	end
	def create
		favo_farmer = FavoFarmer.where(:user_id => current_user.id, :farmer_id => params[:farmer_id])
		favo_farmer.present? ? favo_farmer.destroy_all : favo_farmer.create
		render plain: ""
	end
end
