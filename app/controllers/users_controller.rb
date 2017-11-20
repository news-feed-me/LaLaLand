class UsersController < ApplicationController
  layout false

  require 'NewsAPI_Source'
  include NewsAPI_Source

  before_action :check_log_in, :except => [:create, :new]
  $no_subscriptions = false

  def new
    @user = User.new
    @subs1 = Subscription.all
  end

  def create
    @subs1 = Subscription.all
    @user = User.new(user_params)
    if @user.valid? and params['sources']
      if @user.save
        params['sources'].each do |source|
          subscribes = Subscribe.new(:user_id => @user.user_id,
            :subscription_id => Subscription.find_by_name(source).subscription_id)
          if subscribes.save
            # Do nothing
          else
            render action: "new"
          end
        end
        flash[:notice] = "User was successfully created"
        redirect_to(:controller => 'Access', :action => 'login')
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
    @subs = Subscription.all
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
