class StaticController < ApplicationController
  http_basic_authenticate_with name: "letme", password: "in", only: :exception_test

  def about_us
    set_page_description("手機王(首機網路) 近20年來默默善盡企業社會責任，積極扮演企業公民的角色。透過友故事，聚集更多友善小農和支持者，將更多的理念和故事，傳遞給大家。與友善小農交朋友，鼓勵他們努力種出更優質、對環境更友善的作物。")
    set_page_image "https://www.ugooz.cc/assets/sk2/img/ui/logo.png"
    set_page_title "關於我們"
  end

  def terms_of_service
    set_page_description("感謝您蒞臨友故事網站，友故事網站為 首機網路股份有限公司所經營管理之網路平台，為保障您的權益，請於使用本網站服務或註冊成為本網站會員前，詳細閱讀本服務條款...")
    set_page_image "https://www.ugooz.cc/assets/sk2/img/ui/logo.png"
    set_page_title "服務條款"
  end

  def privacy_policy
    set_page_description("一、本政策適用範圍:  1. 本隱私權政策適用於您在本網站活動時，所涉及的個人資料蒐集、運用與保護，包含：使用者名稱、年齡、性別、職業、通訊地址、 Email...")
    set_page_image "https://www.ugooz.cc/assets/sk2/img/ui/logo.png"
    set_page_title "隱私權政策"
  end

  def exception_test
    raise "This endpoint is designed to fail!"
  end

end
