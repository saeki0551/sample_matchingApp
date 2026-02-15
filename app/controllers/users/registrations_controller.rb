# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  # def create
  #   binding.pry
  # end

  # def create 
  #   if params[:user].present?
  #     session[:user] = user_params
  #     redirect_to new_user_information_path
  #   else
  #     ActiveRecord::Base.transaction do
  #       user = User.new(session[:user])
  #       binding.pry
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