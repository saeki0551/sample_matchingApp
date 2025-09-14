class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = current_user
    if @user.update(user_params)
      # binding.pry
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
