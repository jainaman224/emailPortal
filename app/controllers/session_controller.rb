class SessionController < ApplicationController
  before_action :authenticate_user, :only => [:profile]
  before_action :save_login_state, :only => [:login, :login_attempt]

  def login
  end

  def logout
    flash[:success] = "Logged out successfully"
    session[:user_id] = nil
    redirect_to :action => 'login'
  end

  def profile
  end

  def login_attempt
    authorized_user = User.authenticate(login_params[:username], login_params[:password])

    if authorized_user
      session[:user_id] = authorized_user.id
      session[:account_id] = authorized_user.account.first ? authorized_user.account.first.id : nil

      account = authorized_user.account.first

      if not session[:account_id].nil?
        HardWorker.perform_async(account.id, account.email_id, account.password, account.client)
      end

      flash[:success] = "Welcome again, you logged in as #{authorized_user.username}"
      redirect_to :controller => 'account', :action => "index"
    else
      flash[:danger] = "Invalid Username or Password"
      redirect_to :action => 'login'
    end
  end

  private
  def login_params
    params.require(:session).permit(:username, :password)
  end
end
