# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def create
    @user = User.new(create_user_params)
    # @user.user_information = UserInformation.new(user_information_params)
    if @user.user_information.image.attached?
      #なにもしない
    else
      @user.user_information.image.attach(io: File.open("app/assets/images/defaultUserIcon.png"), filename: "defaultUserIcon.png", content_type: "image/png")
    end
  
    if @user.save
      sign_in(@user)
      redirect_to users_path, notice: "アカウントの作成に成功しました。"
    else
      @created_user = User.select(:email).find_by(email: @user.email) # select email from users where email = '101@101';
      if @user.email == @created_user.email
        flash.now[:alert] = "このメールアドレスは登録されています。ログインしてください。" 
        render "users/new"
      else
        render "users/new"
        flash.now[:alert] = "予想外のエラー、アカウントの作成に失敗しました。"
      end
    end 
  end
  
  private
  def create_user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, user_information_attributes: [:image, :age, :birth_date, :prefecture_id, :hobby_id])
  end

  # private
  # def user_information_params
  #   params.require(:user_information).permit(:age, :birth_date, :prefecture_id, :hobby_id, user_information_attributes: [:image])
  # end

  def after_sign_up_path_for(resource) 
    users_path #サインアップ遷移先のパス
  end
end

