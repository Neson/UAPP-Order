class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def uapp
    @user = User.from_uapp(request.env["omniauth.auth"])
    sign_in @user
    set_flash_message(:notice, :success, :kind => "UAPP") if is_navigational_format?
    redirect_to session[:login_redirect_path] || root_path
  end
end
