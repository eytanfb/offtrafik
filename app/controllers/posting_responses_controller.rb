class PostingResponsesController < ApplicationController
  
  def accept
    @posting_response = PostingResponse.find params[:posting_response_id]
    @posting_response.accepted = true
    if @posting_response.save
      flash[:success] = "#{@posting_response.responder.name}'i yolculugunuza kabul ettiniz"
      redirect_to @posting_response.posting
    end
  end
  
  def reject
    @posting_response = PostingResponse.find params[:posting_response_id]
    @posting_response.accepted = false
    if @posting_response.save
      flash[:success] = "#{@posting_response.responder.name}'i yolculugunuza reddettiniz"
      redirect_to @posting_response.posting
    end
  end
end
