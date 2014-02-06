# encoding: utf-8

class StaticPagesController < ApplicationController
  def home
    @districts = District.pluck(:name)
    path = if signed_in?
      if current_user.has_past_responses?
        user_past_responses_path(current_user)
      else
        user_postings_path(current_user)
      end
    end  
    redirect_to path unless path.nil?
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
    send_file "#{Rails.root}/app/assets/documents/Terms-And-Conditions.pdf", type: 'application/pdf'
  end
    
end
