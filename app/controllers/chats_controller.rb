class ChatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    chat = Chat.new(user_id: user_params[:user_id])
    chat.save
  end

  def user_params
    params.permit(:user_id)
  end
end
