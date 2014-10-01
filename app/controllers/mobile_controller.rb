class MobileController < ApplicationController
  def mobile_sign_in
    email = params[:user][:email]
    password = params[:user][:password]
    user = User.find_by_email email
    if user && user.valid_password?(password)
      sign_in user 
      logger.info "Signed user in"
      respond_to do |format|
        format.json { render json: { user: user, token: user.confirmation_token, all_postings: Posting.live_postings.to_json(include: :user) } }
      end
    else
      logger.info "Not signed in"
      respond_to do |format|
        format.json { render json: '"bad_request":"not able to sign in"' }
      end
    end
  end

  def user_request
    user = User.find params[:mobile_id]
    respond_to do |format|
      format.json { render json: user.to_json(include: :postings)  }
    end
  end
  
end
