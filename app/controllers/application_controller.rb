class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protect_from_forgery prepend: true

  def after_sign_in_path_for(resource)
    if is_admin
      products_path
    elsif is_seller
      root_path
    elsif is_buyer
      root_path
    elsif is_guest
      root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :role])
  end
end
