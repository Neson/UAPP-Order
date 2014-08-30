class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def uapp
    @user = User.from_uapp(request.env["omniauth.auth"])
    sign_in @user
    set_flash_message(:notice, :success, :kind => "UAPP") if is_navigational_format?
    # cookies[:user_logined] = { value: true, domain: Setting.uapp_url.gsub(/https?:\/\//, '').gsub(/\//, '').gsub(/^[^\.]*/, '') }
    cookies[:user_logined] = { value: true, domain: '.' + Setting.uapp_url.gsub(/https?:\/\//, '').gsub(/\//, '') }
    redirect_to session[:login_redirect_path] || root_path
  end
end
