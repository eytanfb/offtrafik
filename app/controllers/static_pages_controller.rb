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
  
  def admin
    if current_user.admin?
      @user_count = User.count
      @posting_count = Posting.count
      @live_posting_count = Posting.live_postings.count
    else
      flash[:notice] = "Bu sayfaya erişiminiz yoktur."
      redirect_to current_user
    end
  end
  
end
