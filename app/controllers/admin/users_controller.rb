module Admin
  class UsersController < BaseController
    def index
      @users = User.all
    end
    def destroy
      user = User.find_by(id: user_params[:id])
      user.destroy
      redirect_to admin_users_path
    end

    private
    def user_params
      params.permit(:id)
    end
  end
end
