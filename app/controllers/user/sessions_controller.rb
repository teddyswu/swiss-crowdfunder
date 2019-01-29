# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    set_page_description "加入友故事，可以閱讀故事，獲得知識傳遞；也可以參與提案，鼓勵小農，為環境盡一份心力，進而建立友善關係。"
    set_page_image "https://www.ugooz.cc/assets/sk2/img/ui/logo.png"
    set_page_title "會員登入與註冊"
    super
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
