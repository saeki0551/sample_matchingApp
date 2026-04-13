class LikesController < ApplicationController
  def create
    @like = Like.new(user_id: current_user.id, liked_user_id: params[:user_id])
    unless @like.save
      redirect_to users_path, alert: "いいねができませんでした。"
    end
  end

  def destroy
    @like = Like.find(params[:id])
    unless @like.destroy
      redirect_to users_path, alert: "いいねが削除できませんでした。"
    end
  end

  private

    def like_params
      params.permit(:id, :user_id)
    end
end