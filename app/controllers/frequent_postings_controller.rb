# encoding: utf-8

class FrequentPostingsController < ApplicationController
  
  def index
    
  end
  
  def create
    @frequent_posting = current_user.frequent_postings.new params[:frequent_posting]  
    fp = params[:frequent_posting]
    days = fp[:days].reject { |k, v| v == "0" }.keys
    if !days.empty? && @frequent_posting.save
      today = Date.today
      date = Date.parse(fp[:last_date])
      from_address = fp[:from_address]
      to_address = fp[:to_address]
      starting_time = fp[:starting_time]
      ending_time = fp[:ending_time]      
      driving = fp[:driving]
      smoking = fp[:smoking]
      comments = fp[:comments]
      while today < date do
        current_user.postings.create!(date:today, to_address:to_address, from_address: from_address, starting_time: starting_time, ending_time: ending_time, driving: driving, smoking: smoking, comments: comments) if days.include? Date::DAYNAMES[today.wday]
        today += 1
      end
      flash[:success] = "Ilan verildi"
      redirect_to share_posting_path(posting_id: @frequent_posting.id)
    else
      flash[:warning] = "Ilan verirken bir sorun olustu. Lutfen hatalari kontrol edip tekrar deneyin."
      driving_options
      @posting = current_user.postings.new params[:posting]
      render template: "postings/new"
    end
  end
  
  private
  
  def driving_options
    @driving_options = %w(Sürücü Yolcu Taksi\ Paylasimi)
  end
end
