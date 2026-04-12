class LikesController < ApplicationController
  def create
    @like = Like.new(likes_user_id: current_user.id, user_id: params[:user_id])
    unless @like.save
      redirect_to users_path, alert: "いいねができませんでした。"
    end
  end

  def destroy
    @like = Like.find_by(params[:id])
    unless @like.destroy
      redirect_to users_path, alert: "いいねが削除できませんでした。"
    end
  end

  private

    def like_params
      params.permit(:id, :user_id)
    end
end