class EmailController < ApplicationController
  def index
    @emails = Email.paginate(:page => params[:page], :per_page => 30).order('date DESC')
  end

  def show
    @email = Email.find(params[:id])
    @email.read = true
    @email.save
  end

  def destroy
    @email = Email.find(params[:id])
    @email.destroy
    redirect_to :action => 'index'
  end
end
