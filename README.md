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

Then set environment variable using

> export EMAIL_ID=`<USERNAME>`

> export EMAIL_PASSWORD=`<PASS>`

To use outlook

> export EMAIL_CLIENT='outlook'

Then run mailman script in one terminal using

> ruby script/mailman_server

and finally run main server on another terminal as

> bin/rails server

## TODO

1. Support for multiple email clients.
2. Account and User implementation.
3. Reply to same thread using in-reply: <message-id> in header.
4. Run `mailman_server` from main server.
5. Get unread information from email client.
6. Support for attachments.
7. Support for html_body.

## Contributors

Aman Jain (jainaman224)
