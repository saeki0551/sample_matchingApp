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

  # def new
  #   @user = User.new
  # end

  # def create 
  #   if params[:user].present?
  #     user = User.new(user_params)  
  #     session[:user] = user 
           
  #     user.check_password
  #     return redirect_to  new_user_path, alert: user.check_password if user.check_password.present?
      
  #     user.already_sign_up?
  #     return redirect_to  new_user_path, flash: { alert: "新規登録できませんでした。再度、新規登録またはログインしてください。"} if user.already_sign_up?

  #     if created_user = User.order(updated_at: :desc).limit(1).select(:is_deleted, :cancel_membership_count, :cancel_membership_time).find_by(email: user.email, is_deleted: true)
  #       if user.already_cancel_membership?(created_user, ACCOUNT_STOP_TIME)
  #         return redirect_to  new_user_path, flash: { alert: "新規登録できませんでした。ログインするか、#{ACCOUNT_STOP_TIME} 秒後に新規登録してください。"  }
  #       else
  #         user.cancel_membership_count = created_user.cancel_membership_count + 1 
  #         session[:user][:cancel_membership_count] = user.cancel_membership_count
  #       end
  #     end

  #     binding.pry

  #     redirect_to new_user_information_path(user)
  #   else
  #     ActiveRecord::Base.transaction do
  #       user = User.new(session[:user])
  #       user.save!
  #       @user_information.user_id = user.id
  #       @user_information.save!
  #       sign_in(user)
  #     end
  #     redirect_to users_path, notice: "アカウントの作成に成功しました。"
  #   end
  # end

  # private

  #   def user_params
  #     params.require(:user).permit(:email, :password, :password_confirmation)
  #   end
end