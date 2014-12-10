class JobType
  include Mongoid::Document
    field :name, type: String
    has_many :jobs
end
