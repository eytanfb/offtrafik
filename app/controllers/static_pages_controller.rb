# encoding: utf-8

class StaticPagesController < ApplicationController
  def home
    @districts = District.pluck(:name)
    redirect_to user_postings_path(current_user) if signed_in?
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
