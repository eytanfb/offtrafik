# encoding: utf-8

class StaticPagesController < ApplicationController
  
  caches_action :welcome
  
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
