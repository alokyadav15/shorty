class UserMailer < ActionMailer::Base
  default from: "info@satak.in"


 def token_email(user)
    @user = user
    @token  = @user.current_token
    mail(to: @user.email, subject: 'Your Token Key ' )
  end


end
