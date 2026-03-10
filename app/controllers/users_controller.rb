class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :cancel_membership]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end


  def destroy
    user = User.find(params[:id])
    return redirect_to users_path, alert: "ユーザーidが一致しないため、退会ができません。"  unless user.id == current_user.id

    if user.update(is_deleted: true, cancel_membership_time: DateTime.now)
      sign_out(user)
      redirect_to cancel_membership_user_path
    else
      redirect_to users_path, alert: "予想外のエラー、退会に失敗しました。"
    end
  end

  def cancel_membership
    @account_stop_time = ACCOUNT_STOP_TIME
  end
end