class ChatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @chat = Chat.new
  end

  def create
    chat = Chat.new(user_params)
    chat.save
  end

  def user_params
    params.require(:chat).permit(:message).merge(user_ids: [current_user.id])
  end
end
