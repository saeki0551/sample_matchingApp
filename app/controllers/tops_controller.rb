class TopsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
  end

end
