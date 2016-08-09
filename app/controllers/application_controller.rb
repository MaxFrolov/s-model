class ApplicationController < ActionController::Base
  include BaseControllerMethods

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:password, :password_confirmation, :first_name, :last_name, :phone])
    devise_parameter_sanitizer.permit(:account_update, keys: [:password, :password_confirmation, :first_name, :last_name, :phone])
  end
end
