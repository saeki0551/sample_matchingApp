class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new]

  def index
    @users = User.where(is_deleted: false)
  end

  def new
    @user = User.new
  end
  
  def destroy
    user = User.find(params[:id])
    return redirect_to users_path, alert: "ユーザーidが一致しないため、アカウントの削除ができません。"  unless user.id == current_user.id

    if user.update(is_deleted: true)
      redirect_to destroy_user_session_path, notice: "アカウントの削除が完了しました"
    else
      redirect_to users_path, alert: "予想外のエラー、アカウントの削除に失敗しました。" 
    end
  end
end