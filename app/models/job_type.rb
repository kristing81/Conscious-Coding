class JobType
  include Mongoid::Document
    field :name, type: String
    embeds_many :jobs
end
