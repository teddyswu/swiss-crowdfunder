module OrdersHelper

  def render_is_paid(campaign_id, goody_id, id, is_paid)
  	if is_paid == false
  		link_to "未付款", campaign_goody_order_path(campaign_id, goody_id, id)
  	else
  		"已付款(<a href=\"/\">取消</a>)".html_safe
  	end
  end

  def render_how_to_pay(payment_type)
  	case payment_type
  	when "Credit_CreditCard"
  		"信用卡"
  	when "BARCODE_BARCODE"
  		"7-11 ibon 代碼繳款"
  	when "CVS_CVS" 
  		"超商代碼繳款"
		when "CVS_OK" 
			"OK 超商代碼繳款"
		when "CVS_FAMILY" 
			"全家超商代碼繳款"
		when "CVS_HILIFE" 
			"萊爾富超商代碼繳款"
		when "GooglePay"
			"GooglePay"
	  end
  end

end