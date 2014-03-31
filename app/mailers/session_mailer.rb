class SessionMailer < ActionMailer::Base
  default from: "no-reply@imaginatio-shopcart.herokuapp.comm"
  
  def reset_password(user)
    @user = user
    @url  = password_recovery_path(user.remember_token, :only_path => false)
    mail(to: @user.email, subject: 'Password recovery mail')
  end
end
