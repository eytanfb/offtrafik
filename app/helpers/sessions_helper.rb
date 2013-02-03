module SessionsHelper
  
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end
  
  def signed_in? # returns the signed_in boolean
    !current_user.nil?
  end
  
  def current_user=(user) # this defines what the assignment of current_user would do
    @current_user = user
  end
  
  def current_user # this defines what would return when asked for current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end
  
  def sign_out
    self.current_user = nil;
    cookies.delete(:remember_token)
  end
  
end
