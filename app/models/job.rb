require 'httparty'
class Job
  include Mongoid::Document
  include Mongoid::Timestamps
  #attr_accessible :title, :description, :category, :job_type, :location,:skills, :company, :url

  field :title, type: String
  field :description, type: String
  field :category, type: String
  field :location, type: String
  field :created_at, type: Date
  field :skills, type: Array, default: []
  field :company, type: String
  field :url, type: String

  belongs_to :employer
  belongs_to :category
  accepts_nested_attributes_for :category
  belongs_to :job_type
  scope :newest_first, lambda { order("jobs.created_at DESC") }
  scope :recent, lambda { where("jobs. created_at => 1.week.ago") }


  validates_presence_of :title

  def raw_skills
    self.skills.join(",")
  end

  def raw_skills=(skill_string)
    self.skills = skill_string.split(",")
  end

  def self.recent # All prices of last week.
      where(:created_at => 1.week.ago)
  end

  def self.search(params)

    jobs = Job.scoped

    if skills
      jobs.where(:skills.in => skills.split(",").collect(&:strip))
    end

    if title
      jobs.where(params[:title]).split(" ").collect(&:strip)
      #Job.any_of(title: /^#{title}/i)
      #jobs.where(:title => Regexp.new(title, true))
      #jobs.where(title: /#{Regexp.escape(search)}/i) 
      #jobs.where(title.split(" ").collect(&:strip))
    end

    # if description
    #   jobs.where(description.split(" ").collect(&:strip))
    # end
    jobs

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
