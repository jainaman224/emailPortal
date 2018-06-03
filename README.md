# EmailPortal

It is an portal for email management at our server. It fetches email from your email client and show on your dashboard. You can also send email from the same portal.

## Dependencies

**NOTE** It is not supported on ruby 2.5.x due to [this](https://github.com/mikel/mail/issues/1209).

Ruby version: 2.4.4
Rails version: 5.2.0

It is recommended to install ruby using [RVM](https://rvm.io).

## How to run

Clone the project.

> git clone https://github.com/jainaman224/emailPortal.git

Then move to project using

> cd emailPortal

To install all dependencies use

> bundle install

Run sidekiq as a separate process

> bundle exec sidekiq

and finally run main server on another terminal as

> bin/rails server

## TODO

1. Reply to same thread using in-reply: <message-id> in header.
2. Get unread information from email client.
3. Support for attachments.
4. Support for html_body.
5. Exception Handling.
6. Proper job queue management.
7. Password Encryption Fix.

## Contributors

Aman Jain (jainaman224)
