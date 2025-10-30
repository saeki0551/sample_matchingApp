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
    @created_user = User.order(updated_at: :desc).limit(1).find_by(email: @user.email)
    return redirect_to  new_user_path, alert: "このユーザーは作成済みです。ログインしてください。" if @created_user.present?
    return redirect_to  new_user_path, alert: "パスワードが間違っています。" if @user.password != @user.password_confirmation
    if @user.save
      sign_in(@user)
      redirect_to users_path, notice: "アカウントの作成に成功しました。"
    else
      flash.now[:alert] = "予想外のエラー、アカウントの作成に失敗しました。"
      render "users/new"
    end 
  end

  private

    def create_user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation, user_information_attributes: [:image, :age, :birth_date, :prefecture_id, :hobby_id])
    end

    def after_sign_up_path_for(resource) 
      users_path #サインアップ遷移先のパス
    end
end

