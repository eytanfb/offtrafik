class StaticPagesController < ApplicationController
  def home
    session[:posting_params] = session[:posting_step] = nil
    if signed_in?
      @live_postings = current_user.live_postings.paginate(page: params[:page], per_page: 2)
      @past_postings = current_user.past_postings.paginate(page: params[:page], per_page: 2)      
    end
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
  
  def why    
  end
  
end
