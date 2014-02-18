class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :notifications
  
  def notifications
    @notifications = PostingResponse.includes(:posting).where(posting_id: current_user.postings).limit(3).select { |response| response.accepted.nil? } if user_signed_in?
  end
  
end
