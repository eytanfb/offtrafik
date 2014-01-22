# encoding: utf-8

class FrequentPostingsController < ApplicationController
  
  def index
    
  end
  
  def create
    @frequent_posting = current_user.frequent_postings.new params[:frequent_posting]
    if @frequent_posting.save
      flash[:success] = "Ilan verildi"
      redirect_to share_posting_path(posting_id: @frequent_posting.id)
    else
      driving_options
      @posting = current_user.postings.new params[:posting]
      render template: "postings/new"
    end
  end
  
  private
  
  def driving_options
    @driving_options = %w(Farketmez Sürücü Yolcu Taksi)
  end
  
  
end
