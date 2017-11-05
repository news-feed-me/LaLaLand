class AdminController < ApplicationController
  layout "admin"

  def index
    @subscriptions = Subscription.all
  end

  def show
    @subscription = Subscription.find(params[:id])
  end

  def new
    @subscription = Subscription.new
  end

  def create
    # Instatntiate a new object using form parameters
    @subscription = Subscription.new(subscription_params)

    # Save the object
    if @subscription.save
      # If the save succeeds, redirect to the index action
      flash[:notice] = "Subscription created successfully!"
      redirect_to(:action => 'index')
    else
      # If save fails, redisplay the form so user can fix problems
      render('new')
    end
  end

  def edit
    @subscription = Subscription.find(params[:id])
  end

  def update
    # Find an existing object using form parameters
    @subscription = Subscription.find(params[:id])

    # Update the object
    if @subscription.update_attributes(subscription_params)
      # If the save succeeds, redirect to the show action
      flash[:notice] = "Subscription updated successfully!"
      redirect_to(:action => 'show', :id => @subscription.id)
    else
      # If save fails, redisplay the form so user can fix problems
      render('edit')
    end
  end

  def delete
    @subscription = Subscription.find(params[:id])
  end

  def destroy
    subscription = Subscription.find(params[:id]).destroy
    flash[:notice] = "Subscription '#{subscription.name}' destroyed successfully!"
    redirect_to(:action => 'index')
  end

  private
    def subscription_params
      # same as using "params[:subscription]"", except that it:
      # - raises an error if :subscription is not present
      # - allows listed attributes to be mass-assigned
      params.require(:subscription).permit(:name, :url,
        :source_id, :category)
    end
end
