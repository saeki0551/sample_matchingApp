class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(liked_user_id: like_params[:user_id])
    unless @like.save
      redirect_to users_path, alert: 'いいねができませんでした。'
    end
    matching_like = Like.find_by(user_id: @like.liked_user_id, liked_user_id: current_user.id)
    if matching_like
      redirect_to matching_users_path, notice: "#{matching_like.user.user_information.name}さんとマッチングしました。"
    end
  end

  def destroy
    @like = Like.find(like_params[:id])
    unless @like.destroy
      redirect_to users_path, alert: 'いいねが削除できませんでした。'
    end
  end

  def matching_users
    @likes = Like.where(liked_user_id: current_user.id)  
  end

  private

    def like_params
      params.permit(:id, :user_id)
    end
end