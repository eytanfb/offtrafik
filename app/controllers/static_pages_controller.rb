# encoding: utf-8

class StaticPagesController < ApplicationController
  
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
  
  def admin
    if current_user.email == "lsaduk@ku.edu.tr" || current_user.email == "eyanjel@ku.edu.tr"
      @user_count = User.count
      @posting_count = Posting.count
      @live_posting_count = Posting.live_postings.count
      @number_of_users_posted = Posting.pluck(:user_id).uniq.count
    else
      flash[:notice] = "Bu sayfaya erişiminiz yoktur."
      redirect_to find_posting_path 
    end
  end
    
end
