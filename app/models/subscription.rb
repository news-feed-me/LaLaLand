class Subscription < ActiveRecord::Base
  has_many :subscribes
  has_many :users, :through => :subscribes

  scope :search, lambda { |query|
    where(["name LIKE ?" "%#{query}%"])
  }
end
