require 'httparty'
class Job
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String
  field :category, type: Array
  field :job_type, type: Array
  field :location, type: Array
  field :created_on, type: Time
  field :skills, type: Array, default: []
  field :company, type: String
  field :url, type: String
  field :category_id, type: Integer
  field :job_type_id, type: Integer

  belongs_to :employer
  has_one :category
  has_one :job_type
  scope :newest_first, lambda { order("jobs.created_at DESC") }

   include HTTParty
   format :json
   base_uri 'http://api.indeed.com'

  def get_jobs
    jobs = HTTParty.get(" http://api.indeed.com/ads/apisearch?publisher=5153643017932788
      &q=nonprofit
      &as_and=nonprofit
      &as_phr=
      &as_any=designer+developer+%22systems+administrator%22+programmer
      &l=us
      &sort=date
      &radius=
      &st=
      &jt=all
      &start=
      &limit=50
      &fromage=90
      &filter=
      &latlong=
      1&co=us
      &chnl=
      &userip=1.2.3.4
      &useragent=Mozilla/%2F4.0%28Firefox%29&v=2
    ")
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end



  # def initialize(title, description, category, job_type, location, posted_on, skills)
  #   self.title = title
  #   self.description = description
  #   self.category = category
  #   self.job_type = job_type
  #   self.location = location
  #   self.posted_on = posted_on
  #   self.skills = skills
  # end
  # http://api.indeed.com/ads/apisearch?publisher=5153643017932788&q=java&l=austin%2C+tx&sort=&radius=&st=&jt=&start=&limit=&fromage=&filter=&latlong=1&co=us&chnl=&userip=1.2.3.4&useragent=Mozilla/%2F4.0%28Firefox%29&v=2


end
