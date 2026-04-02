# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?
    respond_with(resource, serialize_options(resource))
  end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    binding.pry
    if Time.zone.now - self.resource.deleted_at < ACCOUNT_STOP_TIME
      # アカウント停止時間ないなのにログインできてしまう
      sign_out(self.resource)
      return redirect_to new_user_session_path, flash: { alert: "（退会中のため？）ログインできませんでした。" }
    end
    # user = User.order(updated_at: :desc).limit(1).find_by(email: params[:user][:email])
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
