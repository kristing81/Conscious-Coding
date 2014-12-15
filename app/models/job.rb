require 'httparty'
class Job
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String
  field :category, type: String
  field :job_type, type: String
  field :location, type: String
  field :created_on, type: Date
  field :skills, type: Array, default: []
  field :company, type: String
  field :url, type: String
  field :category_id, type: Integer
  field :job_type_id, type: Integer

  belongs_to :employer
  belongs_to :category
  accepts_nested_attributes_for :category
  has_one :job_type
  scope :newest_first, lambda { order("jobs.created_at DESC") }

  validates_presence_of :title

  def raw_skills
    self.skills.join(",")
  end

  def raw_skills=(skill_string)
    self.skills = skill_string.split(",")
  end

  # def search
  #   @search = params[:search]
  # end

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end


   # include HTTParty
   # format :json
   # base_uri 'http://api.indeed.com'


  # def get_jobs
  #   jobs = HTTParty.get(" http://api.indeed.com/ads/apisearch?publisher=5153643017932788
  #     &q=nonprofit
  #     &as_and=nonprofit
  #     &as_phr=
  #     &as_any=designer+developer+%22systems+administrator%22+programmer
  #     &l=us
  #     &sort=date
  #     &radius=
  #     &st=
  #     &jt=all
  #     &start=
  #     &limit=50
  #     &fromage=90
  #     &filter=
  #     &latlong=
  #     1&co=us
  #     &chnl=
  #     &userip=1.2.3.4
  #     &useragent=Mozilla/%2F4.0%28Firefox%29&v=2
  #   ")
  # end



end
