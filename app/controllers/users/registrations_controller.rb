# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController  

  def create
    if params[:user].present?
      session[:user] = sign_up_params
      if User.already_sign_up?(email: session[:user][:email])
        return redirect_to new_user_registration_path, flash: {alert: "新規登録できません。再度、新規登録またはログインして下さい。"}
      end

      if User.check_password(password: session[:user][:password], password_confirmation: session[:user][:password_confirmation])
        return redirect_to new_user_registration_path, flash: {alert: User.check_password(password: session[:user][:password], password_confirmation: session[:user][:password_confirmation])}
      end

      if created_user = User.order(updated_at: :desc).limit(1).select(:is_deleted, :cancel_membership_count, :cancel_membership_time).find_by(email: session[:user][:email], is_deleted: true)
        if User.time_over_cancel_membership?(created_user, ACCOUNT_STOP_TIME)
          return redirect_to new_user_registration_path, flash: {alert: "新規登録できません。一度、時間をおいて新規登録またはログインして下さい。"}
        else
          session[:user][:cancel_membership_count] = created_user.cancel_membership_count + 1
        end
      end

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