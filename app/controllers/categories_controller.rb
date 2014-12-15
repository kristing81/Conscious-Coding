class CategoriesController < ApplicationController

  def index
    @category = Category.find(params[:id])
    @jobs = @category.jobs
  end

  def show
    @category = Category.find(params[:id])
    @jobs = @category.jobs
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(params(:id))
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
  end

  def delete
    @category = Category.find(params[:id])
  end

  def destroy
     @category = Category.find(params[:id]).destroy
     redirect_to jobs_aoth
  end
end
