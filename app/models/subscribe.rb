class Subscribe < ActiveRecord::Base
  belongs_to :users
  belongs_to :subscriptions

  validates_presence_of :user_id
  validates_presence_of :subscription_id
end
