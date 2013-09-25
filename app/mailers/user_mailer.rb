class UserMailer < ActionMailer::Base
  default from: "uyelik@offtrafik.com"
  
  def activation(user_id, guid)
    @user = User.find user_id
    @link = user_activation_path(@user, a: guid)
    mail to: @user.email, subject: "Offtrafik Aktivasyon Linki"
  end
  
end