class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :cancel_membership, :matching_users]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def destroy
    user = User.find(params[:id])
    return redirect_to users_path, alert: 'ユーザーidが一致しないため、退会ができません。'  unless user.id == current_user.id

    if user.update(deleted_at: DateTime.now)
      session[:ensure_user_id] = user.id
      sign_out(user)
      redirect_to cancel_membership_user_path(user)
    else
      redirect_to users_path, alert: '退会に失敗しました。'
    end
  end

  def cancel_membership
    @account_stop_time = ACCOUNT_STOP_TIME
    @user = User.find(user_params[:id])
    return redirect_to new_user_session_path, alert: 'ユーザーidが一致していません。'  unless @user.id == session[:ensure_user_id]
  end

  def matching_users
    @current_user_likes = current_user.likes.all
  end

  private

    def user_params
      params.permit(:id)
    end
end