class StaticPagesController < ApplicationController
  def home
    session[:posting_params] = session[:posting_step] = nil
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
