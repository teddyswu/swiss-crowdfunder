module OrdersHelper

  def render_is_paid(campaign, goody_id, id, is_paid)
  	if is_paid == false
  		link_to "未付款", go_pay_order_path(id)
  	else
      if 100*(campaign.amount_raised.to_f / campaign.goal) > 100 && (campaign.end_date - Date.today).to_i < 1
        "已付款(<a href=\"###\" onClick=\"alert('提案已達成請聯繫提案人')\">取消</a>)".html_safe
      else
  		  "已付款(<a href=\"mailto:#{campaign.email}\">取消</a>)".html_safe
      end
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