class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_users_params)
    session[:user_form] = @user
    redirect_to controller: :user_informations, action: :new, notice: "プロフィール情報を下さい。"
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