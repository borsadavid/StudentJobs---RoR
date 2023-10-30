module CompanyHelper

  def check_company
    if !(user_signed_in? && current_user.company)
      redirect_back(fallback_location: root_path)
      return
    end
  end

  def check_company_permission
    check_company
    if !current_user.enabled 
      flash[:error] = "Account is disabled until document verification!"
      redirect_back(fallback_location: root_path)
      return
    end
  end

  def is_company?(id)
    User.find(id).company
  end

  def is_enabled_company?(id)
    enabled = User.find(id).enabled
    return is_company?(id) && enabled
  end

  def check_user
    unless user_signed_in? && !current_user.company
      redirect_back(fallback_location: root_path)
      return
    end
  end

  def is_user?(id)
    !User.find(id).company
  end

  def is_company_information_verified?(id)
    verified = User.find(id)&.company_information&.verified
    return is_company?(id) && verified
  end

  def display_verified_status(id)
    @status = User.find(id).company_information.status
    if !@status.nil?
      @status
    end
  end

end
