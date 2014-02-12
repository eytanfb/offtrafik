class ApplicationController < ActionController::Base
  protect_from_forgery except: :index
  
  def notifications
    @notifications = PostingResponse.includes(:posting).where(posting_id: current_user.postings).limit(3).select { |response| response.accepted.nil? }
  end
  
end
