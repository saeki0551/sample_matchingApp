# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController  

  def create
    if params[:user].present?
      build_resource(sign_up_params)
      
      unless resource.valid?
        return redirect_to new_user_registration_path, flash: {alert: '新規登録できません。再度、新規登録またはログインして下さい。'}
      end
      
      if resource.check_password(password: sign_up_params[:password], password_confirmation: sign_up_params[:password_confirmation])
        return redirect_to new_user_registration_path, flash: {alert: resource.check_password(password: sign_up_params[:password], password_confirmation: sign_up_params[:password_confirmation])}
      end
      
      if resource.sort_created_user(email: sign_up_params[:email])
        if resource.sort_created_user(email: sign_up_params[:email]).in_time_cancel_membership?(account_stop_time: ACCOUNT_STOP_TIME)
          return redirect_to new_user_registration_path, flash: {alert: '新規登録できません。一度、時間をおいて新規登録またはログインして下さい。'}
        end
      end

      session[:sign_up_params] = sign_up_params
      redirect_to new_user_information_path
    else
      begin
        ActiveRecord::Base.transaction do
          build_resource(session[:sign_up_params])
          resource.save
          # user_information = @user.build_user_information(user_information_params)
          user_information.save!
        end
      rescue => e
        logger.error(e.message)
        return redirect_to new_user_registration_path, flash: {alert: "新規登録できません。再度、新規登録またはログインして下さい。"}
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