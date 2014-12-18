class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_user
    if current_applicant    
      current_applicant
    else
      current_employer
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def after_sign_in_path_for(applicants)
    redirect_to jobs_path
  end

  def after_sign_in_path_for(employers)
    redirect_to edit_employer_path
  end
  def employer?
    if 
      current_user.employer?
      return true
    end
  end

  def authorize_employer
    unless employer?
      flash[:error] = "Sorry you don't have permission to do that"
      redirect_to root_path
      false
    end
  end

end
