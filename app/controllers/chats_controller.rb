class ChatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :show]

  def new
    @chat = Chat.new
  end

  def create
    chat = Chat.new(chat_params)
    chat.save
  end

  def show
    binding.pry
    @chat = Chat.find(user_params)
    new_user_chat_path(current_user.id)
  end

  def user_params
    params.permit(:user_id)
  end

  def chat_params
    params.require(:chat).permit(:message).merge(user_ids: [current_user.id])
  end
end
