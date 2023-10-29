class ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, only: [:apply_to_job]

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
  
  def apply_to_job
    unless Cv.find(params[:cv_id]).user.id == current_user.id
      return
    end
    apply = Application.create(apply_params)
    if apply.save
      @message = "Application sent!"
    else
      @message = "Failed to send application."
    end
    respond_to do |f|
      f.html {redirect_back}
      f.js {
        render  :template => "layouts/notice",
                :layout => false
      }
    end
  end

  def cancel_application
    unless Application.find(params[:id]).cv.user.id == current_user.id
      return
    end
    @app = Application.find(params[:id])
    if @app.viewed
      return
    end
    if @app.destroy
      @message = "Application cancelled"
    else
      @message = "Something went wrong."
    end
    respond_to do |f|
      f.html {redirect_back}
      f.js {
        render  :template => "layouts/notice",
                :layout => false
      }
    end
  end

private

  def apply_params
    params.permit(:job_id, :cv_id)
  end
end