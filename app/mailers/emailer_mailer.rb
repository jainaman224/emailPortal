class EmailerMailer < ApplicationMailer
  default from: ENV['GMAIL_USERNAME']

  def send_email
    @details = params[:details]
    mail(to: @details['to'], subject: @details['subject'])
  end
end
