class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :check_url
  before_filter :get_app_setting
  before_action :save_page_history
  before_action :login_control

  def doorkeeper_unauthorized_render_options
    {:json => {:error => {:message => "Not authorized", :code => 401}}}
  end

  def get_app_setting
    # Get data from Core and store it into cache
    if !Rails.cache.read("uapp_data") || params['exc'] == "true"
      uapp_data = HTTParty.get Setting.uapp_url + '/api/v1/site_data.json'
      Rails.cache.write("uapp_data", uapp_data.parsed_response, :expires_in => 30.minutes)
    end

    # Fallback to Site Setting if App Setting dosen't exists
    @uapp_data = Rails.cache.read("uapp_data")
    Setting['site_name'] = @uapp_data['site_name'] if Setting['site_name'].to_s == ''
    Setting['org_name'] = @uapp_data['org_name'] if Setting['org_name'].to_s == ''
    Setting['administrator_url'] = @uapp_data['administrator_url'] if Setting['administrator_url'].to_s == ''
    Setting['administrator_email'] = @uapp_data['administrator_email'] if Setting['administrator_email'].to_s == ''
    Setting['mailer_sender'] = @uapp_data['mailer_sender'] if Setting['mailer_sender'].to_s == ''
    Setting['google_analytics_id'] = @uapp_data['google_analytics_id'] if Setting['google_analytics_id'].to_s == ''

    # The settings are loaded with '/app/models/setting.rb'
    @app_name = Setting.app_name
    @google_analytics_id = Setting.google_analytics_id
  end

  def after_sign_in_path_for(resource)
    if resource.class == Staff
      staff_path
    else
      super
    end
  end

  def can_order
    if Preference.order_deadline.to_s != '' && Time.parse(Preference.order_deadline) < Time.now
      return false
    elsif Preference.order_starttime.to_s != '' && Time.parse(Preference.order_starttime) > Time.now
    else
      return true
    end
  end

  private

  def check_url
    Rails.logger = Rails.application.config.logger if !!Rails.application.config.logger
    if !request.original_url.match(/#{Setting.app_url.gsub(/\/$/, '')}/)
      redirect_to(Setting.app_url.gsub(/\/$/, '') + request.fullpath) && return
    end
  end

  def save_page_history
    (session[:page_history] ||= []).unshift request.fullpath
    session[:page_history].pop if session[:page_history].length > 4
    session[:login_redirect_path] = session[:page_history][1] || root_path
  end

  def login_control
    if params[:controller] != 'users/omniauth_callbacks'
      if cookies[:login_token].to_s != ""
        if !current_user
          redirect_to(user_omniauth_authorize_path(:uapp))
        else
          if cookies[:login_token_gtime] < (Time.now - 1.days).to_i.to_s || Digest::MD5.hexdigest(Setting.site_secret_key + cookies[:login_token_gtime] + current_user.uid.to_s) != cookies[:login_token] || (cookies[:login_update_time] && cookies[:login_update_time] > current_user.data_update_time.to_i.to_s)
            sign_out current_user
            redirect_to(user_omniauth_authorize_path(:uapp))
          end
        end
      elsif !!current_user
        sign_out current_user
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end
end
