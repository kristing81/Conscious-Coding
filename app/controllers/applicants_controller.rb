class ApplicantsController < ApplicationController
  #before_action :set_applicant, only: [:show, :edit, :update, :destroy]

  def create
    auth = request.env['omniauth.auth']
    @applicant = Applicant.find_with_omniauth(auth)
    @applicant = Applicant.create_with_omniauth(auth)
    if @applicant.save 
      redirect_to root_url, flash[:notice] = "Successfully signed in!"
    else
      redirect_to root_url, flash[:notice] = "There was an error.  Please try again"
    end
  end

  def show
    # authorize! :read, @applicant
  end

  def edit
    # authorize! :update, @applicant
  end

  def update
    # authorize! :update, @applicant
    respond_to do |format|
      if @applicant.update(applicant_params)
        sign_in(@applicant == current_user ? @applicant : current_user, :bypass => true)
        format.html { redirect_to @applicant, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # authorize! :delete, @applicant
    @applicant.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
  
  private
  def set_user
    @applicant = applicant.find(params[:id])
  end

  def applicant_params
    accessible = [ :name, :email, :access_toke, :secret ] # extend with your own params
    accessible << [ :password, :password_confirmation ] unless params[:applicant][:password].blank?
    params.require(:applicant).permit(accessible)
  end
end
