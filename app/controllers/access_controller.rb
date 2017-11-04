class AccessController < ApplicationController
  #before_action should be put
  before_action :check_log_in, :except => [:login, :attempt_login, :logout]

  def index
  end

  def login
  end

  def attempt_login
  	if params[:username].present? && params[:password].present?
  		found_user = User.where(:username => params[:username]).first
  		if found_user 
  			authroized_user = found_user.authenticate(params[:password])
  		end
  	end
  	# if user is valid, go to user's menu
  	if authroized_user
      #save userid & name to sessions
      session[:userid] = authroized_user.id
      session[:username] = authroized_user.username
  		#redirect_to user's menu
  		redirect_to(:action => 'index')
  	else
  		redirect_to(:action => 'login')
  	end
  end


  def logout
    #remove the information in session
    session[:userid] = nil
    session[:username] = nil
  	#if user logs out, redirect to login page
  	redirect_to(:action => "login")
  end

end
