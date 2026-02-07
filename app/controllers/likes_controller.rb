class LikesController < ApplicationController
  def create
    @user = User.find_by(id: params[:liked_user_id])
    @like = Like.new(user_id: params[:user_id], liked_user_id: params[:liked_user_id])
    @like.save
    respond_to do |format|
      format.turbo_stream 
    end
  end

  def destroy
    @user = User.find_by(id: params[:liked_user_id])
    @like = Like.find_by(user_id: params[:user_id], liked_user_id: params[:liked_user_id])
    @like.destroy
    respond_to do |format|
      format.turbo_stream
    end
  end
end