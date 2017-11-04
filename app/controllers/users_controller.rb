class UsersController < ApplicationController
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




  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :eamil, :birth_date, :password, :country, :profile_picture, :password_digest)

    end
end
