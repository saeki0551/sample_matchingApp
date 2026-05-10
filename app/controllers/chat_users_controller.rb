class ChatUsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new]
  
  def new
    @chat_user = ChatUser.new(user_params)
    binding.pry
  end

  def user_params
    params.permit(:user_id)
  end
end
