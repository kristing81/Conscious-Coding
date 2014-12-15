class JobsController < ApplicationController

  # def index
  #   @jobs = Job.search(params[:search])
  #   if params[:category_name].blank?
  #     @jobs = Job.all.newest_first
  #   else
  #     @category_id = Category.where(slug: params[:category_name]).first.id
  #     @jobs = Job.where(category_id: @category_id).newest_first
  #   end
  # end

  def index
     @jobs = Job.all#search(params[:search])
  end

  def new
    @job = Job.new
  end

  def create
    @category = Category.find(params[:category_id]) 
    @job = Job.new(job_params)
    #@job = current_user.jobs.build(job_params)
    @job.category = @category
    if @job.save
      flash[:notice] = "Job has been successfully created"
      redirect_to jobs_path #[@job.category, @job]
    else
      flash[:error] = "There was an error saving the Job.  Please try again"
      render :new
    end
  end


  private

  def job_params
    params.require(:job).permit(:title, :description, :category_id, :job_type_id, :location, :posted_on, :raw_skills,:company, :url)
  end 
end