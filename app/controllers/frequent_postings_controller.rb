# encoding: utf-8

class FrequentPostingsController < ApplicationController
  
  def index
    
  end
  
  def create
    @frequent_posting = current_user.frequent_postings.new params[:frequent_posting]  
    if @frequent_posting.save
      fp = params[:frequent_posting]
      days = fp[:days].reject { |k,v| v == "0" }.keys
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

# sample params
# {"days"=>{"Sunday"=>"0", "Monday"=>"1", "Tuesday"=>"0", "Wednesday"=>"1", "Thursday"=>"0", "Friday"=>"1", "Saturday"=>"0"}, "last_date"=>"23-04-2014", "starting_time"=>"10:41", "ending_time"=>"11:11", "driving"=>"Sürücü", "smoking"=>"Hayır", "comments"=>"Okula her sabah zamaninda gitmek istiyorum. Muhtemelen Resitpasadan gidecegim.", "from_address"=>"Ortakoy", "to_address"=>"Koc Universitesi"}
