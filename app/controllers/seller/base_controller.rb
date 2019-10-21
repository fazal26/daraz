class Seller::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_seller

  private
    def authenticate_seller
      redirect_to(products_path) && return if !current_user.has_role?(:seller)
    end
end
