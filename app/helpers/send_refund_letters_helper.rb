module SendRefundLettersHelper
	def render_is_send(status)
		status == true ? "已寄送" : "排程中"
	end
end
