# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end


  # POST /resource/sign_in
  def create
    パスワードなしでもログインできてしまう
    resource = User.order(updated_at: :desc).find_by(email: params[:user][:email])
    if resource.deleted_at
      sign_out(resource)
      return redirect_to new_user_session_path, flash: { alert: "（退会中のため？）ログインできませんでした。" }
    end
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end


  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
