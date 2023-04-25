class UserMailer < ApplicationMailer

  def welcome_email(code)
    @code = code
    mail(to: 'xcl8202@qq.com', subject: 'Welcome to My Awesome Site')
  end
end
