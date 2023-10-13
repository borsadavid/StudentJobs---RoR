class UserInformationController < ApplicationController

  def new
    if current_user && current_user.user_information.present?
      @user_information = current_user.user_information
    else
      @user_information = UserInformation.new
    end
  end

  def update
    user = User.find(current_user.id)
    @user_information = user.user_information
    if @user_information.update(user_information_params)
      flash[:success] = "Personal information updated!"
      redirect_to landing_path
    else
      flash[:error] = "Something went wrong."
      render 'edit'
    end
  end

  def create
    user = User.find(current_user.id)
    if user.user_information.exists?
      flash[:error] = "You already added the personal information."
      update
      return
    end
    @user_information = user.build_user_information(user_information_params)
    if @user_information.save
      flash[:success] = "Personal information saved!"
      redirect_to landing_path
    else
      flash[:error] = "Something went wrong."
      #render 'new'
    end
  end

  def destroy
    account_information = current_user.user_information
  
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
    params.require(:user_information).permit(:first_name, :last_name, :address, :birthdate, :sex, :phone_number, :country, :county, :city)
  end


end