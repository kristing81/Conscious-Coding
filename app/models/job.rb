class Job
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String
  field :name, type: String
  field :category, type: Array
  field :job_type, type: Array
  field :location, type: Array
  field :posted_on, type: Time
  field :skills, type: Array

  embedded_in :employer
end
