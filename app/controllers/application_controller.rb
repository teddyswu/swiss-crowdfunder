class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale,
                :http_check
  rescue_from ActiveRecord::RecordNotFound, with: :render_404


  def set_locale
    I18n.locale = if %w[de en].include?(params[:locale])
                    params[:locale]
                  else
                    I18n.default_locale
                  end
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def http_check
    if request.host.include?("ugooz")
      redirect_to request.original_url.gsub("http","https"), :status => 301 if request.original_url.include?("http://")
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    session[:redirect_path].present? ? session[:redirect_path] : root_path
  end

  private
  def render_404
    render "errors/not_found"
  end

end
