class Subscription < ActiveRecord::Base
  has_many :subscribes
  has_many :users, :through => :subscribes
  has_many :articles

  scope :searchName, lambda { |query|
    where("name ILIKE ?", "%#{query}%")
  }

  scope :searchID, lambda { |query|
    where("source_id ILIKE ?", "%#{query}%")
  }

  scope :searchCategory, lambda { |query|
    where("category ILIKE ?", "%#{query}%")
  }

  validates_presence_of :name
  validates_presence_of :url
  validates_presence_of :source_id


end
