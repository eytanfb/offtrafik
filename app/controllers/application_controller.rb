require_dependency 'posting_response'
class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :notifications
  
  before_filter :set_locale

  def notifications
    logger.info "notifications"
    if user_signed_in?
      @notifications = PostingResponse.future.where(posting_id: current_user.postings.pluck(:id)).limit(3).select { |response| response.accepted.nil? }
      @notifications_count = @notifications.count
    end
  end

  def get_past_responses
    logger.info "get_past_responses"
    if user_signed_in?
      @postings_with_past_responses = []
      user_postings  = current_user.unagreed_postings
      user_responses = current_user.accepted_past_responses
      @postings_with_past_responses << user_postings
      @postings_with_past_responses << user_responses
      @postings_with_past_responses.flatten!
    end
  end
  
  def after_sign_in_path_for(user)
      if user.has_showable_journeys?
        user_past_responses_path(user)
      else
        find_posting_path
      end
  end

  private

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
    # current_user.locale
    # request.subdomain
    # request.env["HTTP_ACCEPT_LANGUAGE"]
    # request.remote_ip
  end

  def default_url_options(options = {})
    {locale: I18n.locale}
  end
end

private

  def miniprofiler
    Rack::MiniProfiler.authorize_request if Rails.env.staging? && current_user.email == "example-0@ku.edu.tr" 
  end
