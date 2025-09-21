class UserInformationsController < ApplicationController
  def new
    @user_information = UserInformation.new
  end

  def create
    @user_information = UserInformation.new(user_information_params)
    # binding.pry
    if @user_information.save
      redirect_to users_path
    else
      render :back
    end 
  end

  private
  def user_information_params
    params.require(:user_information).permit(:image, :age, :birth_date, :prefecture_id, :hobby_id).merge(user_id: current_user.id)
    # binding.pry
  end
end
