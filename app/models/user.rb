class User < ActiveRecord::Base
  has_many :subscribes

  # scope- keyword
  # :getUserID - is name of the function
  # lambda
  # query this database for the specific name;
  scope :getUserRecord, lambda {|userName| where ("user_name == #{userName}")}

  scope :getUserID, lambda {select ('userid')}


  # @record = User.getUserID().getUserRecord(userName_FromLogin)


end
