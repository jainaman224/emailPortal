class EmailController < ApplicationController
  def index
    @emails = Email.paginate(:page => params[:page], :per_page => 30).order('date DESC')
  end

  def show
    @email = Email.find(params[:id])
    @email.read = true
    @email.save
  end

  def new
    @email = Email.new
  end

  def create
    EmailerMailer.with(details: email_params.as_json).send_email.deliver_later
    redirect_to :action => 'index'
  end

  def destroy
    @email = Email.find(params[:id])
    @email.destroy
    redirect_to :action => 'index'
  end

  private
  def email_params
    params.require(:email).permit(:to, :subject, :text_body)
  end
end
