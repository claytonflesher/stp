class ApplicationMailer < ActionMailer::Base
  default from: ENV['EMAIL_USER_NAME']
  layout 'mailer'
end
