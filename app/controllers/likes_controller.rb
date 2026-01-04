class LikesController < ApplicationController
  def create
    like = Like.new(user_id: params[:user_id], liked_user_id: params[:liked_user_id])
    if like.save
      redirect_to users_path
    else
      redirect_to users_path, alert: "いいねができませんでした。"
    end
  end

  def destroy
    like = Like.find_by(user_id: params[:user_id], liked_user_id: params[:liked_user_id])
    if like.destroy
      redirect_to users_path
    else
      redirect_to users_path, alert: "いいねが削除できませんでした。"
    end
  end
end