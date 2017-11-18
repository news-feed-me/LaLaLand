class AccessController < ApplicationController
  layout false
  #before_action should be put
  before_action :check_log_in, :except => [:login, :attempt_login, :logout]

  def index
  end

  def login
  end

  def attempt_login
  	if params[:user_name].present? && params[:password].present?
  		found_user = User.where(:user_name => params[:user_name]).first
  		if found_user
  			authroized_user = found_user.authenticate(params[:password])
  		end
  	end
  	# if user is valid, go to user's menu
  	if authroized_user
      #save userid & name to sessions
      session[:userid] = authroized_user.id
      session[:user_name] = authroized_user.user_name
  		#redirect_to user's menu
  		redirect_to(:controller => 'User', :action => 'ActionOne')
  	else
  		redirect_to(:action => 'login')
  	end
  end


  def logout
    #remove the information in session
    session[:userid] = nil
    session[:user_name] = nil
  	#if user logs out, redirect to login page
  	redirect_to(:action => "login")
  end

end
