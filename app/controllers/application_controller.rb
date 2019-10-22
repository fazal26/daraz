class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protect_from_forgery prepend: true

  def after_sign_in_path_for(resource)
    if is_admin
      admin_dashboard_path
    elsif is_seller
      seller_products_path
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
