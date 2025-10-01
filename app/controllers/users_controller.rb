class UsersController < ApplicationController

  def index
    @users = User.all
    # @user = User.find(15)
    # @user_information = @user.user_information
    # binding.pry
  end

  def destroy
    user = User.find(params[:id])
    # @user_information = UserInformation.find_by(user_id: params[:id])
    # # binding.pry
    # @user_information.delete
    if user.destroy
      redirect_to user_session_path, notice: "アカウントの削除が完了しました"
    else
      flash.now[:alert] = "アカウントの削除に失敗しました"
      render :index
    end
  end
end