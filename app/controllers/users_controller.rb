<<<<<<< HEAD
class UsersController < ApplicationController

  def index
    @users = User.all
    # @user = User.find(15)
    # @user_information = @user.user_information
    # binding.pry
  end

  def destroy
    user = User.find(params[:id])
    # @user_information = UserInformation.find_by(user_id: params[:id])
    # # binding.pry
    # @user_information.delete
    if user.destroy
      redirect_to user_session_path, notice: "アカウントの削除が完了しました"
    else
      flash.now[:alert] = "アカウントの削除に失敗しました"
      render :index
    end
  end
end
=======
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

  def destroy
    user = User.find(params[:id])
    if user.destroy
      redirect_to user_session_path, notice: "アカウントの削除が完了しました"
    else
      flash.now[:alert] = "アカウントの削除に失敗しました"
      render :index
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :age, :birth_date, :prefecture_id, :hobby_id)
  end
end
>>>>>>> 454104b2d7ce57be6e242632dccf5b4f8cc3da2e
