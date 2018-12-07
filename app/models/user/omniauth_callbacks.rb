# -*- encoding : utf-8 -*-
class User
  module OmniauthCallbacks
    
    ["facebook", "tqq", "weibo", "twitter", "qq_connect"].each do |provider|
      define_method "find_or_create_for_#{provider}" do |response|
        
        uid = response["uid"]
        data = response["info"]
        #p response['credentials']['token'] 

        # p "第三方回傳的資訊=============================="
        # p response
        # p "============================================"

        # data["email"] = "sina_#{uid}@example.com" if provider == "weibo" && data["email"].blank?
        # data["email"] = "tqq_#{uid}@example.com" if provider == "tqq" && data["email"].blank?
        # data["email"] = "facebook_#{uid}@example.com" if provider == "facebook" && data["email"].blank?
        # data["email"] = "twitter_#{uid}@example.com" if provider == "twitter" && data["email"].blank?
        # data["email"] = "yahoo_#{uid}@example.com" if provider == "yahoo" && data["email"].blank?
        # data["email"] = "google_#{uid}@example.com" if provider == "google" && data["email"].blank?
        # data["email"] = "qq_connect_#{uid}@example.com" if provider == "qq_connect" && data["email"].blank?
        # 此行要加.readonly(false) 不然會出現 readonly 的例外 TODO 要查
        if user = User.joins(:authorizations).where("authorizations.provider" => provider , "authorizations.uid" => uid).readonly(false).first
          user.skip_confirmation!
          return user
        elsif user = User.find_by_email(data["email"])
          user.skip_confirmation!
          # user.bind_service(response)
          return user
        else
          user = User.new_from_provider_data(provider, uid, data)
          user.skip_confirmation!
          if user.save#(:validate => false)
            user.authorizations << Authorization.new( :provider => provider, :uid => uid )
            up = FarmerProfile.new
            up.user_id = user.id
            up.name = data["nickname"].present? ? data ["nickname"] : data["name"]
            up.name = "u#{Time.now.to_i}" if up.name.blank?
            # up.fb_uid = uid
            #up.gender = (data["user_gender"] == "male"? 1 : 0 )
            #up.birthday = data["user_birthday"]
            up.save
            return user
          else
            Rails.logger.error("User.create_from_hash 失败，#{user.errors.inspect}")
            return nil
          end
        end
        
      end
    end
     
    # 會員新增 function
    def new_from_provider_data(provider, uid, data)
      user = User.find_or_initialize_by( :email => data["email"])
      user.password = Devise.friendly_token[0,20]
      return user
    end
  end

end