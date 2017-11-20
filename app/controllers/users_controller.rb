class UsersController < ApplicationController
  layout 'users'

  $no_subscriptions = false

  before_action :check_log_in, :except => [:create, :new]
  def new
    @user_name = session[:user_name]
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
    @user_name = session[:user_name]
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

  def user_profile
    @user_name = session[:user_name]
    @user = User.find_by_user_id(session[:userid])

  end

  def update
    if params[:commit] == "Update Subscriptions"
      if params.has_key?('sources')
        @user = User.find_by_user_id(session[:userid])
        puts "I reached here!"
        Subscribe.delete_all(:user_id => @user.user_id)
        params['sources'].each do |source|
          subscribe = Subscribe.new(:user_id => @user.user_id,
            :subscription_id => Subscription.find_by_name(source).subscription_id)
            if subscribe.save

            else
              render action: "edit_subscriptions"
            end

        end
        flash[:notice] = "Subscriptions edited successfully"
        redirect_to(:controller => 'user', :action => 'display')
      else
        $no_subscriptions = true
        redirect_to(:action => 'edit_subscriptions')
      end
    elsif params[:commit] == "Update Profile"
      @user = User.find_by_user_id(session[:userid])
      if @user.update_attributes(user_params)
        flash[:notice] = "Profile successfully updated!"
        redirect_to(:controller => 'user', :action => 'display')
      else
        render action: "user_profile"
      end
    end
  end

  def edit_subscriptions
    @user_name = session[:user_name]
    @user = User.find_by_user_id(session[:userid])
    subscribes = User.find_by_user_id(@user.user_id).subscribes
    if subscribes.empty?
      puts "I am empty"
    else
      puts "I am not empty"
    end
    @subscriptions = Array.new(subscribes.size)
    i = 0
    subscribes.each do |subscribe|
      @subscriptions[i] = Subscription.find_by_subscription_id(subscribe.subscription_id)
      i += 1
    end
    @subs1 = Subscription.all
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
