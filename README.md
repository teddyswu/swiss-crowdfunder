README
======

以下為原始專案之範例網站
<https://swiss-crowdfunder.com>.

本專案使用原始網站，再客製化所完成。

但因原始專案Github連結消失，故無法放上來。

主要使用GEM
======

## active_merchant_allpay
金流串接，使用Allpay(歐付寶)支援多方管道
 - Credit card(信用卡)
 - ATM(虛擬ATM)
 - Alipay(支付寶)
 - CVS(超商繳費)
 - BARCODE(超商條碼)
 
## delayed_job_active_record
背景執行排程。將寄信通知，使用背景處理，不影響使用者體驗。

## devise
會員管理系統，並搭配上omniauth達到第三方登入驗證

## carrierwave 加上 mini_magick
圖片裁切以及檔案壓縮
