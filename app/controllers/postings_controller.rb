class PostingsController < ApplicationController
  
  def new
    session[:posting_params] ||= {}
    @posting = current_user.postings.build(session[:posting_params])
    @posting.current_step = session[:posting_step]
    # @json = Posting.all.to_gmaps4rails
  end
  
  def create
    session[:posting_params].deep_merge!(params[:posting]) if params[:posting]
    @posting = current_user.postings.build(session[:posting_params])
    @posting.current_step = session[:posting_step]
    if @posting.valid?
      if params[:back_button]
        @posting.previous_step
      elsif @posting.last_step?
        @posting.save if @posting.all_valid?
      else
        @posting.next_step
      end    
      session[:posting_step] = @posting.current_step
    end
    if @posting.new_record?
      render 'new'
    else
      session[:posting_params] = session[:posting_step] = nil
      flash[:success] = "Ilan verildi"
      redirect_to root_path
    end
  end
end
