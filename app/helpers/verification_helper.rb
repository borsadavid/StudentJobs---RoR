module VerificationHelper

  def check_user_information
    unless current_user.user_information.present?
      redirect_to new_user_information_path
    end
  end
  
end
