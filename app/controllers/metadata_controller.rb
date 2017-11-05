class MetadataController < ApplicationController
  layout false

  def routeToDisplay
    @userName = "ahimani"
    @session = ApiParser.new(@userName)
    subscriptions = @session.getSubscriptions

    for i in 0..1
      puts subscriptions[i].url
      puts subscriptions[i].category
    end

    redirect_to(:controller => 'admin', :action => 'index')
  end
end
