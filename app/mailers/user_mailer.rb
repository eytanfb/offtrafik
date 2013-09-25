class UserMailer < ActionMailer::Base
  default from: "uyelik@offtrafik.com"
  
  def activation(user_id, guid)
    @user = User.find user_id
    @link = activation_path(a: guid)
    mail to: @user.email, subject: "Offtrafik Aktivasyon Linki"
  end
  
end