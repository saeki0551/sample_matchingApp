class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(liked_user_id: like_params[:user_id])
    unless @like.save
      redirect_to users_path, alert: 'いいねができませんでした。'
    end
    matching_like = @like.sort_matching_user
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

  private

    def like_params
      params.permit(:id, :user_id)
    end
end