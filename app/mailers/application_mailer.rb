class ApplicationMailer < ActionMailer::Base
  default from: 'SwissNoReply <verification@sogi.com.tw>'
  layout 'mailer'
end
