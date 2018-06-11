class UserController < ApplicationController
  before_action :save_login_state, :only => [:new, :create]

  def signup
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "You signed up successfully"
      redirect_to :controller => 'session', :action => 'login'
    else
      flash[:danger] = "Invalid form"
      render action: 'signup'
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
