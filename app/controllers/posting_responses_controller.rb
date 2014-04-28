class PostingResponsesController < ApplicationController
  before_filter :notifications, only: [:past_responses]
  before_filter :get_past_responses, only: [:past_responses]
  
  def accept
    if params[:enter_phone][:phone].present?
      current_user.update_attribute(:phone, params[:enter_phone][:phone])
    end
    @posting_response = PostingResponse.find params[:posting_response_id]
    @posting_response.accepted = true
    if @posting_response.save
      PostingResponseMailer.accepted_to_owner(current_user.id, @posting_response.responder.id, @posting_response.posting.id).deliver
      PostingResponseMailer.accepted_to_responder(current_user.id, @posting_response.responder.id, @posting_response.posting.id).deliver
      Rails.cache.delete("notifications")
      Rails.cache.delete("users/#{@posting_response.responder.id}/agreed_journeys")
      Rails.cache.delete("users/#{current_user.id}/agreed_journeys")
    end
    redirect_to @posting_response.posting
  end
  
  def reject
    @posting_response = PostingResponse.find params[:posting_response_id]
    @posting_response.accepted = false
    @posting_response.save
    PostingResponseMailer.rejected_to_responder(current_user.id, @posting_response.responder.id, @posting_response.posting.id).deliver
    Rails.cache.delete("notifications")
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
