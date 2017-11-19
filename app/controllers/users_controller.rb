class UsersController < ApplicationController
  layout false

  $no_subscriptions = false

  before_action :check_log_in, :except => [:create, :new]
  def new
    @sources = Array.new
    @user = User.new
    # add the complete list of sources;
    # probably the easier way would be have it stored in database somewhere
    # instead of making call to API;
    @subs1 = getSources
  end
  require 'NewsAPI_Source'
  include NewsAPI_Source


  def create
    @subs1 = getSources
    @user = User.new(user_params)
    if @user.valid? and params['sources']
      if @user.save
        params['sources'].each do |source|
          subscribes = Subscribe.new(:user_id => @user.user_id,
            :subscription_id => Subscription.find_by_source_id(source).subscription_id)

          if subscribes.save
            # Do nothing
          else
            render action: "new"
          end

      end

        redirect_to(:controller => 'Access', :action => 'login')#, notice: 'User was successfully created'
      else
        render action: "new"
      end

    else
      if !params['sources']
        $no_subscriptions = true
      else
        $no_subscriptions = false
      end
     render action: "new", notice: "Signup errors"
    end
  end

  def list
    @subs = getSources
    render :layout => nil
  end




  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :user_name, :email, :birth_date,
        :password, :country, :profile_picture, :password_digest, :password_confirmation)

    end

  def profile
    @user = User.all
  end



end
