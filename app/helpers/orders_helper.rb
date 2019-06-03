module OrdersHelper

  def render_is_paid(campaign, order)
    if order.status == 4
      "已取消"
    else
      if order.paid == false
    		link_to "未付款", detail_order_path(order.id)
    	else
        if 100*(campaign.amount_raised.to_f / campaign.goal) > 100 && (campaign.end_date - Date.today).to_i < 1
          "成功(<a href=\"###\" onClick=\"alert('提案已達成請聯繫提案人')\">取消</a>)".html_safe
        else
    		  "成功(<a href=\"mailto:#{campaign.email}\" target=\"_blank\">取消</a>)".html_safe
        end
    	end
    end
  end

  def render_pay_or_view(id, is_paid)
    if is_paid == false
      link_to "尚未付款", detail_order_path(id), :class => "btn btn-sm btn-block btn-outline-danger"
    else
      link_to "查看", detail_order_path(id), :class => "btn btn-sm btn-block btn-outline-primary"
    end
  end

  def render_campaign_status(campaign)
    case campaign.result_status
    when 1
      "您支持的提案成功了"
    when 2
      "很可惜提案失敗了"
    when 3
      "提案終止"
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
    when "ATM_TAISHIN"
      "台新銀行 ATM"
    when "ATM_ESUN"
     "玉山銀行 ATM"
    when "ATM_BOT" 
      "台灣銀行 ATM"
    when "ATM_FUBON" 
      "台北富邦 ATM"
    when "ATM_CHINATRUST" 
      "中國信託 ATM"
    when "ATM_FIRST" 
      "第一銀行 ATM"
    when "ATM_LAND" 
      "土地銀行 ATM"
    when "ATM_CATHAY" 
      "國泰世華銀行 ATM"
    when "CVS_OK" 
      "OK 超商代碼繳款"
    when "CVS_FAMILY" 
      "全家超商代碼繳款"
    when "CVS_HILIFE" 
      "萊爾富超商代碼繳款"
    when "CVS_IBON 7-11" 
      "ibon 代碼繳款"
    when "MAN_RM"
      "匯款"
	  end
  end

  def render_is_anonymous(anonymous)
    anonymous == true ? "有" : "無"
  end

end