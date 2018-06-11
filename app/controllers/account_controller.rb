class AccountController < ApplicationController
  before_action :authenticate_user

  def new
    @account = Account.new
  end

  def index
    @accounts = Account.where(user_id: @current_user.id)

    if @accounts.empty?
      redirect_to action: :new
    else
      @active = Account.find(session[:account_id])
    end
  end

  # TODO: Scope limited to user of account.
  def show
    set_account
  end

  def create
    @account = @current_user.account.create(account_params)
    HardWorker.perform_async(@account)
    redirect_to controller: :email, action: :index
  end

  def destroy
    @account.destroy
    redirect_to :action => 'index'
  end

  private
  def set_account
    @account = Account.where(user_id: @current_user.id).find(params[:id])
  end

  def account_params
    params.require(:account).permit(:email_id, :password, :client)
  end
end
