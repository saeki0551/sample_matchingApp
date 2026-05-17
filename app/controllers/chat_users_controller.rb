class ChatUsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search]
  
  def search
    chat_user = ChatUser.find_by(user_id: user_params[:user_id])
    if chat_user
      redirect_to user_chat_path(user_params[:user_id], chat_user.chat_id)
    else
      redirect_to new_user_chat_path(user_params[:user_id])
    end
  end

  

  def user_params
    params.permit(:user_id)
  end
end
