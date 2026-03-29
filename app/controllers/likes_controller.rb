class LikesController < ApplicationController
  def create
    @like = Like.new(user_id: params[:user_id])
    @like.save
  end

  def destroy
    @like = Like.find_by(user_id: params[:user_id], id: params[:id])
    @like.destroy
  end
end