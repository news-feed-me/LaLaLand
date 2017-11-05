class User < ActiveRecord::Base
  has_many :subscribes
  has_many :subscriptions, :through => :subscribes

end
