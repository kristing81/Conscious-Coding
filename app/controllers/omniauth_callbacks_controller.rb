class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    applicant = applicant.from_omniauth(request.env["omniauth.auth"])
    if applicant.persisted?
      flash.notice = "Signed in!"
      sign_in_and_redirect applicant
    else
      session["devise.applicant_attributes"] = applicant.attributes
      redirect_to new_applicant_registration_url
    end
  end
  alias_method :linkedin, :all
end
