class PostingsController < ApplicationController
  
  def create
    
  end
  
  def new
    @posting = current_user.postings.build if signed_in?
  end
end
