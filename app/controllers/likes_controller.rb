class LikesController < ApplicationController
  def create
    begin
      like = current_user.likes.create!(liked_user_id: params[:user_id])
    rescue ActiveRecord::RecordInvalid => e
      logger.error e
      return redirect_to users_path, flash: {alert: 'いいねする相手が存在しません。'}
    end
    if current_user.liked_users.exists?(user_id: like.liked_user_id)
      redirect_to user_path(like.liked_user_id), notice: 'マッチングしました。'
    else
      redirect_to user_path(like.liked_user_id), notice: 'いいねしました。'
    end
  end

  def destroy
    begin
      like = current_user.likes.find(params[:id])
      like.destroy!
    rescue ActiveRecord::RecordNotFound => e
      logger.error e
      return redirect_to users_path, flash: {alert: 'いいねする相手が存在しません。'}
    end
    redirect_to user_path(like.liked_user_id), notice: 'いいねを削除しました。'
  end
end