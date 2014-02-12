class PostingResponsesController < ApplicationController
  
  def accept
    @posting_response = PostingResponse.find params[:posting_response_id]
    @posting_response.accepted = true
    @posting_response.save
    @telephone = true if current_user.phone.nil?
  end
  
  def reject
    @posting_response = PostingResponse.find params[:posting_response_id]
    @posting_response.accepted = false
    @posting_response.save
  end
  
  def past_responses
    @postings_with_past_responses = []
    user_postings  = current_user.unagreed_postings
    user_responses = current_user.accepted_past_responses
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
  
  def not_happened
    @posting_response = PostingResponse.find params[:posting_response_id]
    if current_user == @posting_response.posting.user
      @posting_response.poster_agreed = false
    else
      @posting_response.responder_agreed = false
    end
    @posting_response.save
  end
end
