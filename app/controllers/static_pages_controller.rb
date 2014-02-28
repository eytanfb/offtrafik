# encoding: utf-8

class StaticPagesController < ApplicationController
  def home
    @posting = Posting.new params[:posting]
    path = if signed_in?
      if current_user.has_showable_journeys?
        user_past_responses_path(current_user)
      else
        find_posting_path
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
  
  def welcome
    render layout: false
  end
    
end
