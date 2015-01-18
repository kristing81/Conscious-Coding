class WelcomeController < ApplicationController
  def index
    @jobs = Job.newest_first
    search_term = ["nonprofit developer engineer"]
    search_term << params[:title] if params[:title].present?
    #search_term << params[:skills].gsub("," , ' ')
    @indeed_jobs = IndeedAPI.search_jobs(
        :q => search_term.join(" "),
        start: 10 * (params[:page].to_i - 1),
        limit: 10,
        sort: 'date')
  end

  def about
  end
end
