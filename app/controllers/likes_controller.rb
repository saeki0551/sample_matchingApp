class LikesController < ApplicationController
  def create
    like = current_user.likes.new(liked_user_id: like_user_id_params[:user_id])
    begin
      like.save!
    rescue => e
      logger.error(e.message)
      return redirect_to users_path, flash: {alert: 'いいねできません、もしくは相手のユーザーの取得に失敗しました。'}
    end
    if current_user.liked_users.exists?(user_id: like_user_id_params[:user_id])
      redirect_to user_path(like.liked_user_id), notice: 'マッチングしました。'
    else
      redirect_to user_path(like.liked_user_id), notice: 'いいねしました。'
    end
  end

  def destroy
    like = Like.find(like_id_params[:id])
    begin
      like.destroy!
      redirect_to user_path(like.liked_user_id), notice: 'いいねを削除しました。'
    rescue => e
      logger.error(e.message)
      return redirect_to users_path, flash: {alert: 'いいねが削除できませんでした。'}
    end
  end

  private

    def like_user_id_params
      params.permit(:user_id)
    end

    def like_id_params
      params.permit(:id)
    end
end