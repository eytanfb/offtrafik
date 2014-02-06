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
    @postings_with_past_responses = current_user.postings.includes(:posting_responses).select { |posting| posting unless posting.posting_responses.past.empty? }
  end
  
  def happened
    @posting_response = PostingResponse.find params[:posting_response_id]
    if current_user == @posting_response.posting.user
      # @posting_response.posting.poster_agreed
    end
    
  end
end
