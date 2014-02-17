# encoding: utf-8

class PostingsController < ApplicationController
  before_filter :authenticate_user!, only: [:show, :share_posting, :full, :respond, :create, :new]
  before_filter :driving_options, only: [:new, :find, :find_from_home_page]
  before_filter :notifications, only: [:share_posting, :find, :show]
  before_filter :set_districts, only: [:find, :find_from_home_page]
  
  def new
    @posting = current_user.postings.new params[:posting]
    @frequent_posting = current_user.frequent_postings.new params[:frequent_posting]
  end
  
  def create
    params[:posting][:from_address] = params[:from_address]
    params[:posting][:to_address] = params[:to_address]

    @posting = current_user.postings.new params[:posting]
    if @posting.save
      flash[:success] = "Ilan verildi"
      redirect_to share_posting_path(posting_id: @posting.id)
    else
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
    @respondable = !@posting.posting_responses.collect(&:responder_id).include?(current_user.id)
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
    @driving = if params[:posting].present? 
                params[:posting][:driving] == "Farketmez" ? "" : params[:posting][:driving]
              end
    @from_address = params[:posting][:from_address] if params[:posting].present?
    @to_address   = params[:posting][:to_address] if params[:posting].present?

    @postings = params[:posting].present? ? Posting.live_postings.with_from_address(Posting.format(@from_address)).with_to_address(Posting.format(@to_address)).with_driving(@driving).not_current_user(current_user.id) : Posting.live_postings.not_current_user(current_user.id)
    
    @postings = @postings.paginate(page: params[:page], per_page: 10, order: "date asc") if @postings.present?
    
    respond_to do |format|
      format.html
      format.json { render :json => @postings.to_json }
      format.js
    end
  end
  
  def find_from_home_page
    driving = "Farketmez"
    from_address = params[:find_from_home][:from_address]
    to_address = "Koç Üniversitesi"
    postings_found = Posting.live_postings.with_from_address(Posting.format(from_address)).with_to_address(Posting.format(to_address)).with_driving(driving)
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
    posting_response = @posting.posting_responses.new(responder_id: current_user.id)
    if posting_response.save
      text = params[:contact_posting_owner][:content]
      PostingMailer.posting_contact(@posting.user_id, current_user.id, @posting.id, text).deliver
      flash[:success] = "Yanıt isteğiniz yollandı"
      redirect_to user_postings_path(current_user)
    else
      flash[:warning] = "Yanit isteginiz olustrulurken bir sorun cikti. Lutfen tekrar deneyiniz "
    end
  end
  
  def full
    posting = Posting.find params[:posting_id]
    PostingMailer.posting_full(posting.user_id, params[:responder], posting.id).deliver
    flash[:success] = "Ilan dolu emaili yollandı"
    redirect_to user_path(current_user)
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
    @driving_options = %w(Farketmez Sürücü Yolcu Taksi)
  end
  
end
