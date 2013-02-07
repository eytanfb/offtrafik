class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Sign In successful message and redirect to user profile
      sign_in user
      redirect_back_or user
    else
      # Error message and show signin page again
      flash.now[:error] = 'Invalid email/password combination' # .now added to flash to make it appear only on the rendered page
      render 'new'
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
  
end
