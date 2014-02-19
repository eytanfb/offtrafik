# encoding: UTF-8
class UserMailer < ActionMailer::Base
  default from: "uyelik@offtrafik.com"
  
  def welcome(user_id)
    @user = User.find user_id
    
    mail to: @user.email, subject: "Offtrafik’e Hoşgeldin"
  end
  
end