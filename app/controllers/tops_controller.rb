class TopsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :cancel_membership]

  def index
  end

  def cancel_membership
    @account_stop_time = ACCOUNT_STOP_TIME
  end

end
