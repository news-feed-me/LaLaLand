class User < ActiveRecord::Base
  has_many :subscribes
end
