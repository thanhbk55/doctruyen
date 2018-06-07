class Chapter
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :number
  field :content
  belongs_to :book
end
