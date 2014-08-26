class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :get_app_setting
  before_action :save_page_history
  before_action :login_control

  def doorkeeper_unauthorized_render_options
    {:json => {:error => {:message => "Not authorized", :code => 401}}}
  end

  def get_app_setting
    # The settings are loaded with '/app/models/setting.rb'
    @app_name = Setting.app_name
    @google_analytics_id = Setting.google_analytics_id
    if !Rails.cache.read("uapp_data")
      uapp_data = HTTParty.get Setting.uapp_url + '/api/v1/site_data.json'
      Rails.cache.write("uapp_data", uapp_data.parsed_response)
    end
    @uapp_data = Rails.cache.read("uapp_data")
    Setting['site_name'] = @uapp_data['site_name'] if Setting['site_name'].to_s == ''
    Setting['org_name'] = @uapp_data['org_name'] if Setting['org_name'].to_s == ''
    Setting['administrator_url'] = @uapp_data['administrator_url'] if Setting['administrator_url'].to_s == ''
    Setting['administrator_email'] = @uapp_data['administrator_email'] if Setting['administrator_email'].to_s == ''
    Setting['mailer_sender'] = @uapp_data['mailer_sender'] if Setting['mailer_sender'].to_s == ''
    Setting['google_analytics_id'] = @uapp_data['google_analytics_id'] if Setting['google_analytics_id'].to_s == ''
  end

  private

  def save_page_history
    (session[:page_history] ||= []).unshift request.fullpath
    session[:page_history].pop if session[:page_history].length > 10
    session[:login_redirect_path] = session[:page_history][1] || root_path
  end

  def login_control
    if cookies[:user_logined].to_s == "true"
      if !current_user && params[:controller] != 'users/omniauth_callbacks'
        redirect_to(user_omniauth_authorize_path(:uapp))
      end
    elsif !!current_user
      sign_out current_user
    end
  end
end
