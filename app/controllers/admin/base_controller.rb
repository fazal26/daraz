class Admin::BaseController < ApplicationController
  before_action :authenticate_user!  
  before_action :authenticate_admin

  private
    def authenticate_admin
      puts "-------------"
      redirect_to products_path if !current_user.has_role?(:admin)
    end
end