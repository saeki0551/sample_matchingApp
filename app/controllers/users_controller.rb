class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new]

  def index
    @users = User.where(is_deleted: false)
  end

  def new
    @user = User.new
  end
  
  def destroy
    user = current_user
    if user.update(is_deleted: true)
      redirect_to destroy_user_session_path, notice: "アカウントの削除が完了しました"
    else
      flash.now[:alert] = "アカウントの削除に失敗しました"
      render :index
    end
  end
end