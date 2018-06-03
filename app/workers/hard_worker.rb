class HardWorker
  include Sidekiq::Worker

  def perform(account_id, email_id, password, client)
    Mailman.config.poll_interval = 60

    # TODO: Set this variable from config files.
    if client && Rails.application.config.emailServer[:pop].key?(client.to_sym)
      popServer = Rails.application.config.emailServer[:pop][client.to_sym]
    else
      popServer = Rails.application.config.emailServer[:pop][:gmail]
    end

    Mailman.config.pop3 = {
      server: popServer,
      port: 995,
      ssl: true,
      username: email_id,
      password: password
    }

    Mailman::Application.run do
      default do
        begin
          p "hi"
          if message.multipart?
            the_message_html = message.html_part.body.decoded
            the_message_text = message.text_part.body.decoded

            # TODO: Support Attachments.
            # the_message_attachments = []
            # message.attachments.each do |attachment|
            #   file = StringIO.new(attachment.decoded)
            #   file.class.class_eval { attr_accessor :original_filename, :content_type }
            #   file.original_filename = attachment.filename
            #   file.content_type = attachment.mime_type
            #   attachment = Attachment.new
            #   attachment.attached_file = file
            #   attachment.save
            #   the_message_attachments << attachment
            # end
          else
            the_message_html = message.body.decoded
            the_message_text = message.body.decoded
            # the_message_attachments = []
          end

          if !Email.where(message_id: message.message_id).exists?
            Account.find(account_id).email.create(
              :message_id => message.message_id,
              :from => message.from.first,
              :to => message.to.first,
              :subject => message.subject,
              :html_body => the_message_html,
              :text_body => the_message_text,
              :date => message.date
            )
          end

        rescue Exception => e
          Mailman.logger.error "Exception occurred while receiving message:\n#{message}"
          Mailman.logger.error [e, *e.backtrace].join("\n")
        end
      end
    end
  end
end
