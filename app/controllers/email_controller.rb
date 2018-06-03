class EmailController < ApplicationController
  before_action :authenticate_user

  def index
    @emails = Email.where(account_id: session[:account_id]).paginate(:page => params[:page], :per_page => 30).order('date DESC')
  end

  def show
    @email.read = true
    @email.save
  end

  def new
    @email = Email.new
  end

  def create
    EmailerMailer.with(details: email_params.as_json).send_email(session[:account_id]).deliver_later
    redirect_to :action => 'index'
  end

  def destroy
    @email.destroy
    redirect_to :action => 'index'
  end

  private
  def set_email
    @email = Email.where(account_id: session[:account_id]).find(params[:id])
  end

  def email_params
    params.require(:email).permit(:to, :subject, :text_body)
  end
end
