class UsersController < ApplicationController
  before_action :check_log_in, :except => [:create, :new]
  def new
    @user = User.new
  end

  def create

    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User was successfully created'
    else
      render action: "new"
    end
  end

  def list
    @subs = ["abc-news-au", "al-jazeera-english", "ars-technica", "associated-press", "the-economist"]
    render :layout => nil
  end




  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email, :birth_date, :password, :country, :profile_picture, :password_digest)

    end

  def profile
    @user = User.all
  end



end
