class UserInformationsController < ApplicationController

  def new
    @user_information = UserInformation.new
  end

  def create
    user_information = UserInformation.new(user_information_params)
    user_information.user_id = current_user.id
    user_information.save
    redirect_to users_path
  end

  private

    def user_information_params
      params.require(:user_information).permit(:image, :name, :age, :birth_date, :gender, :prefecture_id, :hobby_id)
    end
end
