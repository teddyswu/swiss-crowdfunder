# frozen_string_literal: true

class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
    resource.create_user_profile(:user_id => resource.id, :nickname => params[:nickname])
  end

  # GET /resource/edit
  def edit
    @cities = City.normal_state
    if params[:city_id]
      @districts = District.select("id,name").where(:city_id => params[:city_id])
    else
      @districts = District.where(:city_id => resource.user_profile.city_id)
    end
    UserProfile.find_or_create_by(:user_id => resource.id)
    set_page_title "帳號管理"
    super
  end

  # PUT /resource
  def update
    #==========
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    resource.update_attributes!(user_params)
    resource.user_profile.update_attributes!(user_profile_params)
    set_flash_message! :notice, :updated

    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      bypass_sign_in resource, scope: resource_name
      if params[:s] != ""
        redirect_to "https://m.me/agrisogi?ref=u_advisory" and return
      end
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
    #==========
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  def user_profile_params
    params.require(:user).require(:user_profile).permit(:nickname, :first_name, :last_name, :address, :gender, :birthday, :tel, :cell_phone, :city_id, :district_id, :facebook_url, :postal_code, :country, :introduction)
  end

  def user_params
    params.require(:user).permit(:nickname)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
    edit_user_registration_path
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
