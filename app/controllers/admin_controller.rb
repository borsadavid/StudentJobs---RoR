class AdminController < ApplicationController
  before_action :check_admin

  def index
    @users = User.where.not(id: current_user.id).order(:email)
    @companies = User.where(company: true, enabled: false)
  end

  def enable_company
    @user = CompanyInformation.find(params[:id]).user
    value = !@user.enabled
    @user.update(enabled: value)
  end

  def add_verification_status
    @information = CompanyInformation.find(params[:id])
    @information.update(status: params[:company_information][:status])
    @information.user.update(enabled: false)
  end

  def show_company_information
    @company_information = User.find(params[:id]).company_information
    respond_to do |f|
      f.js 
    end
  end
  
  def block_user
    @user = User.find(params[:id])
    value = !@user.blocked
    respond_to do |f|
      if @user.update(blocked: value)
        f.json { render json: { message: "Success"} }
      else
        f.json { render json: { message: "Error" } }
      end
    end
  end

  def update_admin
    @user = User.find(params[:id])
    value = !@user.admin
    respond_to do |f|
      if @user.update(admin: value)
        f.json { render json: { message: "Success"} }
      else
        f.json { render json: { message: "Error" } }
      end
    end
  end

end