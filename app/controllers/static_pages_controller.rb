class StaticPagesController < ApplicationController
  def home
    @car =  current_user.cars.build if signed_in?
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
