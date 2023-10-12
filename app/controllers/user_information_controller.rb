class UserInformationController < ApplicationController

  def new
  end
  
  def create
    user = User.find(current_user.id)
    user_information = user.build_user_information(user_information_params)
    if user_information.save
      flash[:success] = "Details saved!"
      #redirect_to @object
    else
      flash[:error] = "Something went wrong"
      #render 'new'
    end
  end

  def destroy
    user = User.find(params[:id])
    account_information = user.user_information
  
    if account_information
      account_information.destroy
      flash[:notice] = 'Your details have been successfully deleted.'
    else
      flash[:alert] = 'You do not have associated account information.'
    end
  
    #redirect_to users_path
  end
  
  
private

  def user_information_params
    params.permit(:first_name, :last_name, :address, :birthdate, :sex, :phone_number)
  end


end