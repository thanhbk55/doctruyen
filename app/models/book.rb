class Book
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :path
  has_many :chapters, dependent: :destroy

end
