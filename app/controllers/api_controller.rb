class ApiController < ApplicationController
  def remote_sign_in
    email = params[:user][:email]
    password = params[:user][:password]
    user = User.find_by_email email
    if user && user.valid_password?(password)
      sign_in user 
      logger.info "Signed user in"
      respond_to do |format|
        format.json { render json: { user: user, my_postings: user.postings, all_postings: Posting.live_postings } }
      end
    else
      logger.info "Not signed in"
      respond_to do |format|
        format.json { render json: '"bad_request":"not able to sign in"' }
      end
    end
  end

  def user_info_request
    user = User.find params[:id]
    respond_to do |format|
      format.json { render json: user.to_json(include: :postings)  }
    end
  end
  
  def all_postings
    @postings = Posting.live_postings
    
    respond_to do |format|
      format.json { render json: @postings.to_json(include: :user) }
    end
  end
  
end
