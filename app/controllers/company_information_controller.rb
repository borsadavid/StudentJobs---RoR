class CompanyInformationController < ApplicationController
  before_action :authenticate_user!
  before_action :check_company

  def update
    @company_information = current_user.company_information
    respond_to do |f|
      if @company_information.update(company_information_params)
        @company_information.update(status: "Pending verification")
        f.json { render json: {message: "Saved."}}
      else
        f.json { render json: {message: "Something went wrong!"}}
      end
    end
  end

  def create
    user = User.find(current_user.id)
    @company_information = user.build_company_information(company_information_params)
    respond_to do |f|
      if @company_information.save
        f.js
        f.json { render json: {message: "Saved."}}
      else
        f.json { render json: {message: "Something went wrong!"}}
      end
    end
  end

  def destroy
    company_information = current_user.company_information
  
    if company_information
      company_information.destroy
      return
    else
      return
    end
  
    #redirect_to users_path
  end
  
  
private

  def company_information_params
    params.require(:company_information).permit(:address,:phone_number,:country, :name)
  end


end