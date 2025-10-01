class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]

  def index
    @users = User.all
    # @user = User.find(15)
    # @user_information = @user.user_information
    # binding.pry
  end

  def new
    @user = User.new
  end

  def create
    # binding.pry
    # @user = User.new(create_users_params)
  end

  
  def destroy
    user = User.find(params[:id])
    if user.destroy
      redirect_to user_session_path, notice: "アカウントの削除が完了しました"
    else
      flash.now[:alert] = "アカウントの削除に失敗しました"
      render :index
    end
  end

  private
  def create_users_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end