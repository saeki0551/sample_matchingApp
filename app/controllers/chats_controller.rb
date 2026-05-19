class ChatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :show]

  def new
    @chat = Chat.new
    @chat_user_id = chat_user_params
  end

  def create
    chat = Chat.new(user_ids: [current_user.id, user_params[:user_id]])
    chat.save
  end

  def show
    @chat = Chat.find(chat_user_params[:id])
  end

  def user_params
    params.permit(:user_id)
  end

  def chat_params
    params.require(:chat).permit(:message).merge(user_ids: [current_user.id, params[:chat][:user_id]])
  end

  def chat_user_params
    binding.pry
    params.require(:chat_user).permit(:id)
  end
end
