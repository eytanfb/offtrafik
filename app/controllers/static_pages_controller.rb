class StaticPagesController < ApplicationController
  def home
    redirect_to user_postings_path if signed_in?
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
  
  def why    
  end
  
  def terms_and_conditions 
  end
  
end
