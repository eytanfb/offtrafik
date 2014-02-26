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
      flash[:success] = "Ilan verildi"
      PostingMailer.new_one_time_posting_given(current_user.id, @posting.id).deliver
      redirect_to share_posting_path(posting_id: @posting.id)
    else
      flash[:warning] = "Ilan verirken bir sorun olustu. Lutfen hatalari kontrol edip tekrar deneyin."
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
    @to_from = "#{to_address} - #{from_address}"
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
      flash[:success] = "Ilan silinmiştir!"
      redirect_to current_user
    else
      flash[:warning] = "Ilan silinememiştir. Lütfen tekrar deneyiniz."
      redirect_to @posting
    end
  end
  
  def find
    @posting = Posting.new params[:posting]
    @driving = params[:posting][:driving] if params[:posting].present?
    @driving = "Taksi" if @driving == "Taksi Paylasimi"
    @from_address = params[:posting][:from_address] if params[:posting].present?
    @to_address   = params[:posting][:to_address] if params[:posting].present?

    @postings = params[:posting].present? ? Posting.live_postings.with_from_address(Posting.format(@from_address)).with_to_address(Posting.format(@to_address)).with_driving(@driving) : Posting.live_postings
    
    @postings = @postings.includes(:user).paginate(page: params[:page], per_page: 6, order: "date asc") if @postings.present?
    
    respond_to do |format|
      format.html
      format.json { render :json => @postings.to_json }
      format.js
    end
  end
  
  def find_from_home_page
    @posting = Posting.new params[:find_from_home]
    driving = ""
    to_address = params[:find_from_home][:to_address]
    from_address = params[:find_from_home][:from_address]
    postings_found = Posting.live_postings.with_from_address(Posting.format(from_address)).with_to_address(Posting.format(to_address)).with_driving(driving)
     if postings_found.blank?
       postings_found = Posting.live_postings.with_from_address(from_address)
       postings_found = Posting.live_postings if postings_found.blank?
       flash.now[:warning] = "Bulundugunuz yerden aradıgınız adrese ilan bulunamadı. Ama belki aşagıdakiler hoşunuza gider!"
     end
    @postings = postings_found.paginate page: params[:page], per_page: 6, order: "date asc"
    @from_address = from_address
    @to_address = to_address
    @driving = driving
    
    respond_to do |format|
      format.html
      format.js
    end
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
      text = params[:contact_posting_owner][:content]
      PostingMailer.posting_contact(@posting.user_id, current_user.id, @posting.id, text).deliver
      flash[:success] = "Yanıt isteğiniz yollandı"
      redirect_to find_posting_path
    else
      flash[:warning] = "Yanit isteginiz olustrulurken bir sorun cikti. Lutfen tekrar deneyiniz "
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
