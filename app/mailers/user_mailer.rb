class UserMailer < ActionMailer::Base
  default from: "uyelik@offtrafik.com"
  
  def activation(user_id)
    @user = User.find user_id
    # @link = user_activation_path @user, a: @user.activation_guid)
    mail to: @user.email, subject: "Offtrafik Aktivasyon Linki"
  end
  
end