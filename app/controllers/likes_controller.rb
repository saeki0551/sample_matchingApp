class LikesController < ApplicationController
  def create
    @like = Like.new(current_user_id: current_user.id, user_id: params[:user_id])
    @user = @like.user_id
    unless @like.save
      redirect_to users_path, alert: "いいねができませんでした。"
    end
  end

  def destroy
    @like = Like.find_by(user_id: params[:user_id], id: params[:id])
    @user = @like.user_id
    unless @like.destroy
      redirect_to users_path, alert: "いいねが削除できませんでした。"
    end
  end
end