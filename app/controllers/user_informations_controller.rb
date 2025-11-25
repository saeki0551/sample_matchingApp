class UserInformationsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new]

  def new
    @user = User.new(user_params)
    if User.exists?(email: @user.email)
      created_user = User.order(updated_at: :desc).limit(1).select(:email, :is_deleted, :cancel_membership_count, :cancel_membership_time).find_by(email: @user.email)
      return redirect_to  new_user_path, alert: "新規登録できませんでした。ログインするか、一定時間後に新規登録してください。" unless created_user.is_deleted 
      return redirect_to  new_user_path, alert: "新規登録できませんでした。ログインするか、一定時間後に新規登録してください。" if created_user.is_deleted && Time.zone.now - created_user.cancel_membership_time < ACCOUNT_STOP_TIME
    
      if Time.zone.now - created_user.cancel_membership_time >= ACCOUNT_STOP_TIME  && created_user.is_deleted 
        @user.cancel_membership_count = created_user.cancel_membership_count + 1
      end 
    end
    @user.check_password
    return redirect_to  new_user_path, alert: @user.check_password if @user.check_password.present?
    
    @user_information = UserInformation.new
  end


  private

    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end

