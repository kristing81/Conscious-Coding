require 'httparty'
class Job
  include Mongoid::Document
  include Mongoid::Timestamps

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
  scope :newest_first, lambda { desc(:created_at) }
  scope :recent, lambda { where(:created_at.gte => 1.week.ago) }


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

  def self.search(options = {})

    jobs = Job.scoped

    if options[:skills].present?
      jobs = jobs.where(:skills.in => options[:skills].split(",").collect(&:strip))
    end

    if options[:title].present?
      jobs = jobs.where(title: /#{options[:title]}/i)
    end
    jobs
  end
end
