class Subscribe < ActiveRecord::Base
  belongs_to :users
  belongs_to :subscriptions

end
