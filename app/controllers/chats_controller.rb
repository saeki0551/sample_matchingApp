class ChatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new]
  def new
    binding.pry
  end
end
