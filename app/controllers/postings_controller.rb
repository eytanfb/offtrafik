# encoding: utf-8

class PostingsController < ApplicationController
  before_filter :authenticate_user!, only: [:show, :share_posting, :full, :respond]
  before_filter :driving_options, only: [:new, :find, :find_from_home_page]
  
  def new
    @posting = current_user.postings.new params[:posting]
    @frequent_posting = current_user.postings.new params[:posting]
  end
  
  def create
    from_address = params[:posting][:from_address]
    to_address = params[:posting][:to_address]

    @posting = current_user.postings.new params[:posting]
    if @posting.save
      flash[:success] = "Ilan verildi"
      redirect_to share_posting_path(posting_id: @posting.id)
    else
      driving_options
      @frequent_posting = current_user.postings.new params[:posting]
      render 'new'
    end
  end
  
  def show
    @posting = Posting.find(params[:id])
    @user = User.find @posting.user_id
    to_address = @posting.format(@posting.to_address)
    from_address = @posting.format(@posting.from_address)
    @to_from = "#{to_address} - #{from_address}"
  end
  
  def edit
    @posting = Posting.new
  end
  
  def destroy
    @posting = Posting.find params[:id]
    if @posting.destroy
      flash[:success] = "Ilan silinmiştir!"
      redirect_to current_user
    else
      flash[:warning] = "Ilan silinememiştir. Lütfen tekrar deneyiniz."
      redirect_to @posting
    end
  end
  
  def find
    @driving = if params["/find_posting"].present? 
                params["/find_posting"][:driving] == "Farketmez" ? "" : params["/find_posting"][:driving]                
              end
    @from_address = address_parameter_for_search("from_address") if params["/find_posting"].present?
    @to_address = address_parameter_for_search("to_address")     if params["/find_posting"].present?

    @postings = params["/find_posting"].present? ? Posting.live_postings.with_from_address(@from_address).with_to_address(@to_address).with_driving(@driving) : Posting.live_postings
    
    @postings = @postings.paginate(page: params[:page], per_page: 10, order: "date asc") if @postings.present?
    
    respond_to do |format|
      format.html
      format.json { render :json => @postings.to_json }
    end
  end
  
  def find_from_home_page
    driving = "Farketmez"
    from_address = params[:find_from_home][:from_address]
    to_address = "Koç Üniversitesi"
    postings_found = Posting.live_postings.with_from_address(from_address).with_to_address(to_address).with_driving(driving)
     if postings_found.blank?
       postings_found = Posting.live_postings.with_to_address("Koç Üniversitesi")
       flash.now[:warning] = "Aradıgınız adresten Koç Üniversitesi'ne ilan bulunamadı. Ama belki aşagıdakiler hoşunuza gider!"
     end
    @postings = postings_found.paginate page: params[:page], per_page: 10, order: "date asc"
    @from_address_district = from_address
    @to_address_district = to_address
    @driving = driving
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
    text = params[:contact_posting_owner][:content]
    PostingMailer.posting_contact(@posting.user_id, current_user.id, @posting.id, text).deliver
    flash[:success] = "Yanıt isteğiniz yollandı"
    redirect_to user_postings_path(current_user)
  end
  
  def full
    posting = Posting.find params[:posting_id]
    PostingMailer.posting_full(posting.user_id, params[:responder], posting.id).deliver
    flash[:success] = "Ilan dolu emaili yollandı"
    redirect_to user_path(current_user)
  end
  
  private
  
  def address_parameter_for_search(address)
    result = ""    
    result += " #{params['/find_posting']["#{address}"][:district]}" if params['/find_posting']["#{address}"][:district].present?
    result.strip
  end
  
  def driving_options
    @driving_options = %w(Farketmez Sürücü Yolcu Taksi)
  end
  
end
