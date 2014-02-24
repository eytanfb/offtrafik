class PostingResponsesController < ApplicationController
  before_filter :notifications, only: [:past_responses]
  before_filter :get_past_responses, only: [:past_responses]
  
  def accept
    @posting_response = PostingResponse.find params[:posting_response_id]
    @posting_response.accepted = true
    @posting_response.save
  end
  
  def reject
    @posting_response = PostingResponse.find params[:posting_response_id]
    @posting_response.accepted = false
    @posting_response.save
    PostingResponseMailer.rejected_to_responder(current_user.id, @posting_response.responder.id, @posting_response.posting.id).deliver
  end
  
  def past_responses
    get_past_responses
  end
  
  def happened
    @posting_response = PostingResponse.find params[:posting_response_id]
    if current_user == @posting_response.posting.user
      @posting_response.poster_agreed = true
    else
      @posting_response.responder_agreed = true
    end
    @posting_response.save
    if @posting_response.poster_agreed && @posting_response.responder_agreed
      PostingResponseMailer.journey_happened(@posting_response.posting.user.id, @posting_response.responder.id, @posting_response.posting.id).deliver
      PostingResponseMailer.journey_happened(@posting_response.responder.id, @posting_response.posting.user.id, @posting_response.posting.id).deliver
    end
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
