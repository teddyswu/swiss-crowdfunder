# -*- encoding : utf-8 -*-
class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(*providers)
    providers.each do |provider|
      class_eval %Q{
        def #{provider}
          User.transaction do
            if !current_user.blank?
              current_user.bind_service(request.env["omniauth.auth"])#Add an auth to existing
              redirect_to root_path(), :notice => "Bind #{provider} account successfully."
            else
              @user = User.find_or_create_for_#{provider}(request.env["omniauth.auth"])
              if @user == nil
                render :text => "<script>alert('登入失敗，請檢查您的Facebook是否有電子郵件資料，並同意授權我們作為會員帳號使用，謝謝!');location.href='/footers/fb_faq';</script>" and return
              end
              if @user.persisted? 
                sign_in_and_redirect @user, :event => :authentication
              else
                redirect_to new_user_registration_url
              end
            end
          end # transaction
        end
      }
    end
  end
  
  # 原第13行
  # sign_in_and_redirect @user, :event => :authentication, :notice => "Signed in successfully."

  provides_callback_for :facebook, :tqq , :weibo, :twitter, :yahoo, :google, :qq_connect

  # This is solution for existing accout want bind Google login but current_user is always nil
  # https://github.com/intridea/omniauth/issues/185
  def handle_unverified_request
    true
  end


end