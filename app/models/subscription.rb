class Subscription < ActiveRecord::Base
  has_many :subscribes
  has_many :users, :through => :subscribes

  scope :searchName, lambda { |query|
    where(["name LIKE ?", "%#{query}%"])
  }

  scope :searchCategory, lambda { |query|
    where(["category LIKE ?", "%#{query}%"])
  }
end
