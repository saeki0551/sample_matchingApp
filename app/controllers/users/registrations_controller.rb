# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController  
  # def create 
  #   ActiveRecord::Base.transaction do
  #     if params[:user].present?
  #       super
  #     end
  #     user_information.user_id = @user.id
  #     user_information.save!
  #   end
  # end

  # private

  #   def user_params
  #     params.require(:user).permit(:email, :password, :password_confirmation)
  #   end
end