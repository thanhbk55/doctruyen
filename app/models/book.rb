class Book
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  has_many :chapters, dependent: :destroy

end
