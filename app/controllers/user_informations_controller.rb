class UserInformationsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new]

  def new
    @user_information = UserInformation.new
  end

  def show
    @user = User.find(params[:id])
  end

  def remove
    @user = User.find(params[:id])
  end
end
