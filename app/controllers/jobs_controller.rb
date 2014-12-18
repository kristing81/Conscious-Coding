class JobsController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]

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
     @jobs = Job.all
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