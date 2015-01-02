module ApplicationHelper

  def anyone_signed_in?
    user_signed_in? || applicant_signed_in?
  end

end
