class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def check_log_in
    if session[:userid]
      #they have logged in
      return true
    else
      #they are not logged in
      #tell them to log in
      flash[:notice] = "You haven't logged in :("
      redirect_to(:controller => 'access',:action => 'login')
      return false
    end
  end
end
