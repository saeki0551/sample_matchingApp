class UserInformationsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new]

  def new
    @user = User.new(user_params)
    return redirect_to  new_user_path, alert: "Password は英数字である必要があります。" unless /\A[a-zA-Z\d]+\z/.match(@user.password)
    return redirect_to  new_user_path, alert: "Password は6文字以上12文字以内である必要があります。" unless @user.password.length >= 6 && @user.password.length <= 12
    return redirect_to  new_user_path, alert: "Password と Password confirmation が一致していません。" unless @user.password == @user.password_confirmation 

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

