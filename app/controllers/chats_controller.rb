class ChatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  
  def new
    @chat = Chat.new
  end
  
  def create
    @chat = Chat.new
  end

  def user_params
    binding.pry
    params.require(:user).permit(:id)
  end
end
