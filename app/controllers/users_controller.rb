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


<<<<<<< HEAD


  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email, :birth_date, :password, :country, :profile_picture, :password_digest)

    end
=======
  def profile
    @user = User.all
  end

>>>>>>> 9cf17243950c659326b510916cbda96b0d801d6b
end
