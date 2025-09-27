class UserInformationsController < ApplicationController

  def create
    @user_information = UserInformation.new(user_id: current_user.id)
    @user_information.image.attach(io: File.open("app/assets/images/defaultUserIcon.png"), filename: "defaultUserIcon.png", content_type: "image/png")
    if @user_information.save
      redirect_to users_path, notice: "アカウント作成に成功しました"
    else
      redirect_to controller: :tops, action: :index, alert: "アカウントの作成に失敗しました。アカウントを削除して下さい。"
    end 
  end
end
