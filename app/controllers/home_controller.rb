class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_information

  def landing
  end

end