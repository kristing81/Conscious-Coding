class Category
  include Mongoid::Document

  field :name, type: String
  field :slug, type: String

  before_create :slugify

  has_many :jobs


  def slugify
    self.slug = self.name.parameterize
  end
  
  def to_param
    self.slug
  end

end
