class UsersController < ApplicationController
  before_action :set_user, only:[:show, :update, :destory, :edit]

  def update
    @user.update!(edit_user_params)
    @user.image.attach(edit_user_params[:image])
    @user.save
    redirect_to user_path(@user)    
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def edit_user_params
    params.require(:user).permit(:username, :address, :image)
  end
end
