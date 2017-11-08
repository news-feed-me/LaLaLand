class SubscribesController < ApplicationController
  def new
    @subscribe  = Subscribe.new
  end

  def create
    @subscribe = Subscribe.new(subscribe_params)
    if @subscribe.save
      redirect_to @subscribe
    else
      render action: link_to(:controller => 'users', :action =>'new')
    end
  end
end
