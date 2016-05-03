class MessageMailer < ApplicationMailer
  def notify(recipient)
    @recipient    = recipient
    mail to: @recipient.email, subject: '[Secular Therapy Project] New Message'
  end
end
