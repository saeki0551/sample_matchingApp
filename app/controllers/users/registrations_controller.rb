# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController  

  def create
    if params[:user].present?
      build_resource(sign_up_params)
      if resource.already_sign_up?(email: sign_up_params[:email])
        return redirect_to new_user_registration_path, flash: {alert: "新規登録できません。再度、新規登録またはログインして下さい。"}
      end
      
      if resource.check_password(password: sign_up_params[:password], password_confirmation: sign_up_params[:password_confirmation])
        return redirect_to new_user_registration_path, flash: {alert: resource.check_password(password: sign_up_params[:password], password_confirmation: sign_up_params[:password_confirmation])}
      end
      
      created_user = User.order(deleted_at: :desc).limit(1).where(email: sign_up_params[:email]).where.not(deleted_at: nil)
      if created_user.present?
        if User.in_time_cancel_membership?(created_user[0].deleted_at, ACCOUNT_STOP_TIME)
          return redirect_to new_user_registration_path, flash: {alert: "新規登録できません。一度、時間をおいて新規登録またはログインして下さい。"}
        end
      end
      session[:user] = build_resource(sign_up_params)
      redirect_to new_user_information_path
    else
      ActiveRecord::Base.transaction do
        build_resource(session[:user])
        resource.save
        user_information = @user.build_user_information(user_information_params)
        user_information.save!
      end
      set_flash_message! :notice, :signed_up
      sign_up(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    end
  end

  private

    def user_information_params
      params.require(:user_information).permit(:image, :name, :age, :birth_date, :gender, :prefecture_id, :hobby_id)
    end
end