class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :cancel_membership]

  def index
    @users = User.where(deleted_at: nil)
  end

  def new
    @user = User.new
  end

  def destroy
    begin
      user = User.find(params[:id])
      ActiveRecord::Base.transaction do
        user.update!(deleted_at: DateTime.now)
        current_user.likes.each do |like|
          like.destroy!
        end
        current_user.liked_users.each do |liked|
          liked.destroy!
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      logger.error e
      return redirect_to users_path, alert: 'ユーザーidが一致しないため、退会ができません。'
    end
    session[:ensure_user_id] = user.id
    sign_out(user)
    redirect_to cancel_membership_user_path(user)
  end

  def cancel_membership
    @account_stop_time = ACCOUNT_STOP_TIME
    @user = User.find(user_params[:id])
    return redirect_to new_user_session_path, alert: 'ユーザーidが一致していません。'  unless @user.id == session[:ensure_user_id]
  end

  def matching_users
    @matching_users= []
    users = User.all
    current_user.likes.each do |like|
      if current_user.liked_users.find { |liked| liked.user_id == like.liked_user_id }
        @matching_users.push(users.find { |user| user.id == like.liked_user_id })
      end
    end
  end

  private

    def user_params
      params.permit(:id)
    end
end
