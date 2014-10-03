class ApiController < ApplicationController
  def remote_sign_in
    email = params[:user][:email]
    password = params[:user][:password]
    user = User.find_by_email email
    if user && user.valid_password?(password)
      sign_in user 
      logger.info "Signed user in"
      respond_to do |format|
        format.json { render json: { user: user.to_json(include: :postings), all_postings: Posting.live_postings } }
      end
    else
      logger.info "Not signed in"
      respond_to do |format|
        format.json { render json: '"bad_request": "Not able to sign in"' }
      end
    end
  end

  def user_info
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

  def create_daily_posting
    user = User.find params[:user_id]
    posting = user.postings.new params[:posting]
    logger.debug posting.valid?
    if posting.save
      PostingMailer.new_one_time_posting_given(user.id, posting.id).deliver
      respond_to do |format|
        format.json { render json: { all_postings: Posting.live_postings } }
      end
    else
      respond_to do |format|
        format.json { render json: '"bad_request": "Post creaton failed"' }
      end
    end
  end
  
end
