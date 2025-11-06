class UserInformationsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new]

  def new
    @user = User.new(user_params)
    return redirect_to  new_user_path, alert: "パスワードが間違っています。" if @user.password != @user.password_confirmation  

    if User.exists?(email: @user.email) 
      @created_user = User.order(updated_at: :desc).limit(1).find_by(email: @user.email)
      return redirect_to  new_user_path, alert: "このユーザーは作成済みです。ログインしてください。" if @created_user.present?
    end  
    @user_information = UserInformation.new
  end

  private

    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end

