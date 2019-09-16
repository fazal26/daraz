class UsersController < ApplicationController
  before_action :get_user, only:[:show, :update, :destory, :edit]

  def index
    @users = User.all
  end

  def show
  end

  def new
  end

  def create
    puts "________________\n"*100, params.inspect
  end

  def edit
  end

  def update
    @user.update!(edit_user_params)
    redirect_to user_path(@user)    
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def edit_user_params
    params.require(:user).permit(:username, :image)
  end
end
