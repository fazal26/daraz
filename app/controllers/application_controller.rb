class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user!

    before_action :set_current_user

    protect_from_forgery prepend: true


    def set_current_user
      Product.current_user = current_user
    end

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :role])
    end
end
