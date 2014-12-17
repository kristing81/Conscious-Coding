class EmployersController < ApplicationController

  def index
    @employers = Employer.all
  end

  def show
    @employer = Employer.find(params[:id])
    @jobs = @employer.jobs
  end

  def edit
    @employer = Employer.find(params[:id])
  end

  def update
     @employer = Employer.find(params[:id])
     if @employer.update_attributes(employer_params)
      flash[:notice] = "Your profile has been updated"
      redirect_to @employer
    else
      flash[:error] = "There was an error updating your profile.  Please try again"
      render :edit
     end
  end
  
  private

  def employer_params
    params.require(:employer).permit(:location, :company_name, :description, :url, :email, :password)
  end
end





