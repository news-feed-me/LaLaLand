class MetadataController < ApplicationController
  layout "user"

  def index
    @userName = "ahimani"
    @session = ApiParser.new(@userName)
    @subscriptions = @session.getSubscriptions

    #puts @subscriptions[0].source_id
  end
end
