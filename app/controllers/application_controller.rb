class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale,:deny_ip
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

  def deny_ip
    deny_ip = ["41.44.109.146", "72.89.36.208"]
    render_404 if deny_ip.include?(request.remote_ip)
  end

  private
  def render_404
    render "errors/not_found"
  end

end
