class PostingResponsesController < ApplicationController
  
  def accept
    @posting_response = PostingResponse.find params[:posting_response_id]
    @posting_response.accepted = true
    @posting_response.save
  end
  
  def reject
    @posting_response = PostingResponse.find params[:posting_response_id]
    @posting_response.accepted = false
    @posting_response.save
  end
  
  def past_responses
    @postings_with_past_responses = []
    user_postings = current_user.postings.includes(:posting_responses).select { |posting| posting unless posting.posting_responses.past.empty? }
    user_responses = current_user.posting_responses.includes(:posting).map { |response| response.posting if response.posting.date < Date.today }.delete_if { |posting| posting.nil? }
    user_responses.each { |posting| posting.posting_responses.reject! { |response| response.responder.name != current_user.name }}
    @postings_with_past_responses << user_postings
    @postings_with_past_responses << user_responses
    @postings_with_past_responses.flatten!
  end
  
  def happened
    @posting_response = PostingResponse.find params[:posting_response_id]
    if current_user == @posting_response.posting.user
      @posting_response.poster_agreed = true
    else
      @posting_response.responder_agreed = true
    end
    @posting_response.save
  end
end
