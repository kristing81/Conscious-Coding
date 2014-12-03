class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def linkedin
    @applicant = Applicant.find_for_linkedin_oauth(request.env["omniauth.auth"])
    if @applicant.persisted?
      redirect_to root_path, :event => :authentication
    else
      session["devise.linkedin_data"] = request.env["omniauth.auth"]
      redirect_to root_path
    end
  end
end


