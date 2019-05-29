class SendRefundLettersController < ApplicationController
	before_action :authenticate_user!
	before_action :check_admin

	def index
		@rl = SendRefundMail.all.paginate(:page => params[:page], per_page: 10)
	end

	def new
		@campaign = Campaign.where(:result_status => 2)
		@rl = SendRefundMail.new
	end

	def create
		@srm = SendRefundMail.new(send_refund_mail_params)
		srmj = SendRefundMailJob.set(wait_until: @srm.run_at).perform_later
		@srm.delayed_job_id = srmj.job_id
		@srm.is_send = false
		@srm.save!
		redirect_to :action => :index
	end

	def send_refund_mail_params
		params.require(:send_refund_mail).permit(:campaign_id :run_at)
	end

	def check_admin
    redirect_to root_path if current_user.is_admin != true
  end
end
