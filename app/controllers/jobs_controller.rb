class JobsController < ApplicationController

  #before_filter :authenticate_employer!, only: [:new, :create, :edit, :update, :delete:]

  def index
    search_options = params
    @jobs = Job.search(search_options).page(params[:page]).per(10)
    search_term = ["nonprofit developer engineer"]
    search_term << params[:title] if params[:title].present?
    #search_term << params[:skills].gsub("," , ' ')
    @indeed_jobs = IndeedAPI.search_jobs(
        :q => search_term.join(" "),
        start: 10 * (params[:page].to_i - 1),
        limit: 10,
        sort: 'date')
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    #@job = current_user.jobs.build(job_params)
    @job.category = @category
    if @job.save
      flash[:notice] = "Job has been successfully created"
      redirect_to new_charge_path 
    else
      flash[:error] = "There was an error saving the Job.  Please try again"
      render :new
    end
  end

  def edit
     @job = Job.find(params[:id])  
  end
  
  def update
    @job = Job.find(params[:id])  
    if @job.update_attributes(job_params)
      flash[:notice] = "Job has been updated"
      redirect_to [@category, @job]
    else
      flash[:error] = "There was an error editing the Job.  Please try again"
      render :edit
     end
   end
 
   def destroy
     @job = Job.find(params[:id])   
     if @job.destroy
        flash[:notice] = "Job has been deleted"
      redirect_to jobs_path
     else
      flash[:error] = "There was an error deleting the Job.  Please try again"
      render :show
     end
   end

  private

  def job_params
    params.require(:job).permit(:title, :description, :category_id, :job_type_id, :location, :posted_on, :raw_skills,:company, :url)
  end 
end