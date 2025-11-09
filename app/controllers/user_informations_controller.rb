class UserInformationsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new]

  def new
    @user = User.new(user_params)
    return redirect_to  new_user_path, alert: "Password と Password confirmation が一致していません。" if @user.password != @user.password_confirmation  

    if User.exists?(email: @user.email) 
      return redirect_to  new_user_path, alert: "新規登録できませんでした。再度、新規登録またはログインしてください。"
    end  
    @user_information = UserInformation.new
  end

  private

    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end

