# encoding: utf-8

class PostingsController < ApplicationController
  before_filter :authenticate_user!, only: [:show, :share_posting, :full, :respond, :create, :new]
  before_filter :driving_options, only: [:new, :find, :find_from_home_page]
  before_filter :notifications, only: [:share_posting, :find, :show]
  before_filter :get_past_responses, only: [:share_posting, :find, :show]
  
  def new
    @posting = current_user.postings.new params[:posting]
    @frequent_posting = current_user.frequent_postings.new params[:frequent_posting]
  end
  
  def create
    @posting = current_user.postings.new params[:posting]
    if @posting.save
      flash[:success] = "İlan verildi"
      PostingMailer.new_one_time_posting_given(current_user.id, @posting.id).deliver
      redirect_to share_posting_path(posting_id: @posting.id)
    else
      flash[:error] = "İlan verirken bir sorun oluştu. Lütfen hataları kontrol edip tekrar deneyin."
      driving_options
      @frequent_posting = current_user.frequent_postings.new params[:frequent_posting]
      render 'new'
    end
  end
  
  def show
    @posting = Posting.find(params[:id])
    @user = User.find @posting.user_id
    to_address = Posting.format(@posting.to_address)
    from_address = Posting.format(@posting.from_address)
    @respondable = !@posting.posting_responses.includes(:user).collect(&:responder_id).include?(current_user.id)
  end
  
  def preview
    @posting = Posting.find params[:posting_id]
    @user = @posting.user
  end
  
  def edit
    @posting = Posting.new
  end
  
  def destroy
    @posting = Posting.find params[:id]
    if @posting.destroy
      flash[:success] = "İlan silinmiştir!"
      redirect_to current_user
    else
      flash[:warning] = "İlan silinememiştir. Lütfen tekrar deneyiniz."
      redirect_to @posting
    end
  end
  
  def find
    logger.info "find in controller"
    @posting = Posting.new params[:posting]
    if params[:posting].present?
      driving = params[:posting][:driving]
      driving = "Taksi" if driving == "Taksi Paylasimi"
      from_address = params[:posting][:from_address]
      to_address   = params[:posting][:to_address]
      date = params[:posting][:date].present? ? Date.parse(params[:posting][:date]) : Date.today
   end
    
    @postings = if params[:posting].present? 
                  Posting.live_postings.includes(:user).with_from_address(Posting.format(from_address)).with_to_address(Posting.format(to_address)).with_driving(driving).with_date(date).paginate(page: params[:page], per_page: 9, order: "date asc")
                else
                   Posting.live_postings.includes(:user).paginate(page: params[:page], per_page: 9, order: "date asc")
                end
    respond_to do |format|
      format.html
      format.json { render :json => @postings.to_json }
      format.js
    end
  
  def all_postings
    @postings = Posting.live_postings
    
    respond_to do |format|
      format.json { render json: @postings.to_json }
    end
  end
  
  def share_posting
    @posting = Posting.find params[:posting_id]
  end
  
  def respond
    @posting = Posting.find params[:posting_id]
    posting_response = @posting.posting_responses.new(responder_id: current_user.id)
    if posting_response.save
      if params[:contact_posting_owner][:phone].present?
        current_user.update_attribute(:phone, params[:contact_posting_owner][:phone])
      end
      text = params[:contact_posting_owner][:content]
      PostingMailer.posting_contact(@posting.user_id, current_user.id, @posting.id, text).deliver
      flash[:success] = "Yanıt isteğiniz yollandı"
      redirect_to find_posting_path
    else
      flash[:warning] = "Yanıt isteğiniz oluştrulurken bir sorun çıktı. Lütfen tekrar deneyiniz."
    end
  end
  
  def enter_phone
    format.js
  end
  
  private
  
  def set_districts
    @districts = District.all.collect { |d| [d.name, d.name] }
  end
  
  def address_parameter_for_search(address)
    result = ""    
    result += " #{params[:posting]["#{address}"][:district]}" if params[:posting]["#{address}"][:district].present?
    result.strip
  end
  
  def driving_options
    @driving_options = %w(Sürücü Yolcu Taksi\ Paylasimi)
  end
  
end
