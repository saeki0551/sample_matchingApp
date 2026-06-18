class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(liked_user_id: like_params[:user_id])
    unless @like.save
      redirect_to users_path, alert: 'いいねができませんでした。'
    end
    begin
      matching_user = current_user.liked_users.find_by(user_id: like_params[:user_id])
    rescue => e
      logger.error(e.message)
      return redirect_to users_path, flash: {alert: "いいねするユーザーが見つかりません。"}
    end
    if matching_user.liked_user?(user_id: like_params[:user_ids][0])
      redirect_to user_path(matching_user), notice: 'マッチングしました。'
    end
  end

  def destroy
    @like = Like.find(like_params[:id])
    unless @like.destroy
      redirect_to users_path, alert: 'いいねが削除できませんでした。'
    end
  end

  def matching_users
    @likes = Like.where(liked_user_id: user_params[:user_id])  
  end

  private

    def like_params
      params.permit(:id, :user_id)
    end

    def user_params
      params.permit(:user_id)
    end
end