class LikesController < ApplicationController
  def create
    @like = Like.new(user_id: params[:user_id], liked_user_id: params[:liked_user_id])
    @user = User.find_by(id: params[:liked_user_id])
    @like.save
  end

  def destroy
    @like = Like.find_by(user_id: params[:user_id], liked_user_id: params[:liked_user_id])
    @user = User.find_by(id: params[:liked_user_id])
    @like.destroy
  end
end