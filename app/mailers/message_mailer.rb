class MessageMailer < ApplicationMailer
  def notify(recipient)
    @recipient    = recipient
    @conversation = recipient.conversations.last
    mail to: @recipient.email, subject: '[Secular Therapy Project] New Message'
  end
end
