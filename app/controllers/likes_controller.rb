class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(liked_user_id: like_params[:user_id])
    begin
      @like.save!
      matching_like = current_user.liked_users.find_by(user_id: like_params[:user_id])
    rescue => e
      logger.error(e.message)
      return redirect_to users_path, flash: {alert: 'いいねできません、もしくは相手のユーザーの取得に失敗しました。'}
    end
    if matching_like
      redirect_to user_path(matching_like.user), notice: 'マッチングしました。'
    else
      redirect_to user_path(@like.liked_user_id), notice: 'いいねしました。'
    end
  end

  def destroy
    @like = Like.find(like_params[:id])
    begin
      @like.destroy!
      flash[:notice] = 'いいねを削除しました。'
    rescue => e
      logger.error(e.message)
      return redirect_to users_path, flash: {alert: 'いいねが削除できませんでした。'}
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