class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def linkedin
    asd
    @applicant = Applicant.find_for_linkedin_oauth(request.env["omniauth.auth"])
    
    if @applicant.present?
      sign_in_and_redirect @applicant, event: :authentication     
    else
      session["devise.linkedin_data"] = request.env["omniauth.auth"]
      redirect_to root_path
    end
  end

  def after_sign_in_path_for(resource)
    root_url
  end
end


