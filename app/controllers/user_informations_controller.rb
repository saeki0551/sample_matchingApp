class UserInformationsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new]

  def new
    @user = User.new(user_params)
    @user.build_user_information
    # @user_information = UserInformation.new
    # binding.pry
  end
  
  # redirect_to new_user_information_path(@user), notice: "プロフィール情報を入力して下さい。"

  private
  def user_params
    # binding.pry
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
