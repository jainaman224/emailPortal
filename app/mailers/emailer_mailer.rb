class EmailerMailer < ApplicationMailer
  def configure_server(account_id)
    account = Account.find(account_id)

    if account[:client] && Rails.application.config.emailServer[:smtp].key?(account[:client].to_sym)
      smtpServer = Rails.application.config.emailServer[:smtp][account[:client].to_sym]
    else
      smtpServer = Rails.application.config.emailServer[:smtp][:gmail]
    end

    self.smtp_settings = {
      address:              smtpServer,
      port:                 587,
      domain:               "example.com",
      user_name:            account[:email_id],
      password:             account[:password],
      authentication:       "plain",
      enable_starttls_auto: true
    }
  end

  def send_email(account_id)
    configure_server(account_id)
    @details = params[:details]
    mail(to: @details['to'], subject: @details['subject'])
  end
end
