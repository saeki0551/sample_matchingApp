class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    binding.pry
    if @user.save
      redirect_to users_path
    else
      render :back
    end 
  end

  private
  def user_params
    params.require(:user).permit(:name, :age, :birth_date, :prefecture_id, :hobby_id)
  end
end
