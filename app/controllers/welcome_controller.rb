class WelcomeController < ApplicationController
  def index
    @jobs = Job.newest_first
  end

  def about
  end
end
