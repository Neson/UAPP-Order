class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def uapp
    @user = User.from_uapp(request.env["omniauth.auth"])
    sign_in_and_redirect @user
    set_flash_message(:notice, :success, :kind => "UAPP") if is_navigational_format?
  end
end
