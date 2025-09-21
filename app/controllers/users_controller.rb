class UsersController < ApplicationController

  def index
    @users = User.all
    @user_informations = UserInformation.all
    # binding.pry
  end

  def destroy
    @user = User.find(params[:id])
    # @user_information = UserInformation.find_by(user_id: params[:id])
    # # binding.pry
    # @user_information.delete
    @user.destroy
    redirect_to users_path, notice: 'アカウントが削除されました。'
  end

end
