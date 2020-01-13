class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user 

  protected

  def configure_permitted_parameters
    added_attrs = [ :email, :username, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
  
  def after_sign_in_path_for(resource)
    # ログイン後のパスを指定
    root_path
  end

  def after_sign_out_path_for(resource)
    # ログアウト後のパスを指定
    root_path
  end

  def set_current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
