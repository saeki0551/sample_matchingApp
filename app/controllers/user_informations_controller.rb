class UserInformationsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new]

  def new
    @user_information = UserInformation.new
  end

  # def create
    # user_information = UserInformation.new(user_information_params)
  # end

  # private

  #   def user_information_params
  #     params.require(:user_information).permit(:image, :name, :age, :birth_date, :gender, :prefecture_id, :hobby_id)
  #   end
end
