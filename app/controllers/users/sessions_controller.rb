# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def create
    @user = User.find_by(email: params[:user][:email])
    return redirect_to new_user_session_path, alert: "このメールアドレスのユーザーは存在しません。" unless @user.present?
    return redirect_to new_user_session_path, alert: "パスワードが間違っています。" unless @user.valid_password?(params[:user][:password])
    return redirect_to new_user_session_path, alert: "このユーザーは退会済みです。" unless @user.is_deleted == false
    
    sign_in(@user)
    redirect_to users_path, notice: "ログインしました"
  end
end