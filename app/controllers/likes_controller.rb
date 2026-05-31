class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)  
    unless @like.save
      redirect_to users_path, alert: 'いいねができませんでした。'
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
      params.permit(:id, :user_id).merge(user_id: current_user.id, liked_user_id: params[:user_id], user_ids: [current_user.id, params[:user_id]])
    end

    def user_params
      params.permit(:user_id)
    end
end