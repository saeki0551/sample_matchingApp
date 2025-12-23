class Users::UserInformationsController < Users::RegistrationsController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    if User.exists?(email: params[:email]) 
      return redirect_to  new_user_path, alert: "新規登録できませんでした。再度、新規登録またはログインしてください。"
    end 
    @user_information = UserInformation.new
  end

  def create
    @user_information = UserInformation.new(user_information_params)
    super
  end

  private

    def user_information_params
      params.require(:user_information).permit(:image, :name, :age, :birth_date, :gender, :prefecture_id, :hobby_id)
    end
end
