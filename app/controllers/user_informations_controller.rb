class UserInformationsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new]

  def new
    @user_information = UserInformation.new
    @user = User.new(create_users_params)
    session[:user_form] = @user
  end
  
  private
  def create_users_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
