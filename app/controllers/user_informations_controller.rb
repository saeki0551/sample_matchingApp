class UserInformationsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]

  def new
    @user_information = UserInformation.new
  end
end
