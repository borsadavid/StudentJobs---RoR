class ApplicationController < ActionController::Base
  
  include CompanyHelper
  include CvHelper
  include FeedHelper
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:company, :deployed])
    devise_parameter_sanitizer.permit(:account_update, keys: [:company, :deployed])
  end

end
