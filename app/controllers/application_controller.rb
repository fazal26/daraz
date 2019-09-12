class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    protect_from_forgery prepend: true

    def landing_page
        render 'pages/landing_page'
    end
end
