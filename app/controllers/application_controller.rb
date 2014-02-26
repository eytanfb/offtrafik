class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :notifications
  after_filter :flash_to_headers
  
  def notifications
    @notifications = PostingResponse.future.where(posting_id: current_user.postings).limit(3).select { |response| response.accepted.nil? } if user_signed_in?
  end
  
  def get_past_responses
    if user_signed_in?
      @postings_with_past_responses = []
      user_postings  = current_user.unagreed_postings
      user_responses = current_user.accepted_past_responses
      @postings_with_past_responses << user_postings
      @postings_with_past_responses << user_responses
      @postings_with_past_responses.flatten!
    end
  end
 
  private

    def flash_to_headers
      return unless request.xhr?
      response.headers['X-Message'] = flash_message
      response.headers["X-Message-Type"] = flash_type.to_s

      # Prevents flash from appearing after page reload.
      # Side-effect: flash won't appear after a redirect.
      # Comment-out if you use redirects.
      flash.discard
    end

    def flash_message
      [:error, :warning, :notice].each do |type|
        return flash[type] unless flash[type].blank?
      end
      return ''
    end

    def flash_type
      [:error, :warning, :notice].each do |type|
        return type unless flash[type].blank?
      end
    end

end
