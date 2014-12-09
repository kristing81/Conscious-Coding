class JobsController < ApplicationController

  before_filter :find_job, except: [:index]
  
  # def index
  #   @jobs = HTTParty.get(" http://api.indeed.com/ads/apisearch?publisher=5153643017932788&q=java&l=austin%2C+tx&sort=&radius=&st=&jt=&start=&limit=&fromage=&filter=&latlong=1&co=us&chnl=&userip=1.2.3.4&useragent=Mozilla/%2F4.0%28Firefox%29&v=2")
  #   respond_to do |format|
  #   format.html { render "index.html.haml" }
  #   end
  # end

  def index
    if params[:category_name].blank?
      @jobs = Job.all.newest_first
    else
      @category_id = Category.where(slug: params[:category_name]).first.id
      @jobs = Job.where(category_id: @category_id).newest_first
    end
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to @job
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to @job
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to root_path
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :category_id, :job_type, :location, :posted_on, :skills)
  end

  def find_job
    @job = Job.find(:id)
  end
  
end
