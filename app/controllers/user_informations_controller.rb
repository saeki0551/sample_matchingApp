class UserInformationsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]

  def new
    @user_information = UserInformation.new
    @user = User.new(create_users_params)
    session[:user_form] = @user
  end
  
  def create
    @user = User.new(session[:user_form])
    binding.pry
    @user_information = UserInformation.new(user_id: current_user.id)
    if @user_information.image.attached?
      #なにもしない
    else
      @user_information.image.attach(io: File.open("app/assets/images/defaultUserIcon.png"), filename: "defaultUserIcon.png", content_type: "image/png")
    end
    if @user.save && @user_information.save
      redirect_to users_path, notice: "アカウント作成に成功しました"
    else
      redirect_to controller: :tops, action: :index, alert: "アカウントの作成に失敗しました。アカウントを削除して下さい。"
    end 
  end

  private
  def create_users_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end

  private
  def user_information_params
    params.require(:user_information).permit(:age, :birth_date, :prefecture_id, :hobby_id).merge(user_id: current_user.id)
  end
end
