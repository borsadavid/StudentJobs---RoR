class ProfileController < ApplicationController

  def index
    @cv = current_user.cvs.all
    @new_cv = Cv.new
    if is_company?(current_user.id)
      if current_user.company_information.present?
        @company_information = current_user.company_information
      else
        @company_information = CompanyInformation.new
      end
    else
      if current_user.user_information.present?
        @user_information = current_user.user_information
      else
        @user_information = UserInformation.new
      end
    end
  end

end