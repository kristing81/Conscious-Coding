class CategoriesController < ApplicationController

  def index
    @category = Category.find(params[:id])
    @jobs = @category.jobs
  end

  def show
    @category = Category.where(slug: params[:id]).first
    @jobs = @category.jobs
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params.require(:name))
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
     redirect_to root_path
  end
end
