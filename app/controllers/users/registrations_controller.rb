# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController  

  def create
    if params[:user].present?
      session[:user] = sign_up_params
      if User.already_sign_up?(user_email: session[:user][:email])
        flash[:alert] = "新規登録できません。再度、新規登録またはログインして下さい。"
        return redirect_to new_user_registration_path
      end

      redirect_to new_user_information_path
    else
      ActiveRecord::Base.transaction do
        build_resource(session[:user])
        resource.save
        user_information = @user.build_user_information(user_information_params)
        user_information.save!
        redirect_to users_path
      end
    end
  end

  private

    def user_information_params
      params.require(:user_information).permit(:image, :name, :age, :birth_date, :gender, :prefecture_id, :hobby_id)
    end
end