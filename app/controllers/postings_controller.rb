# encoding: utf-8

class PostingsController < ApplicationController
  before_filter :signed_in_user, only: [:show, :share_posting]
  before_filter :districts_and_driving_options, only: [:new, :find]
  
  def new
    @posting = current_user.postings.new params[:posting]
  end
  
  def create
    from_address = params[:posting][:from_address]
    to_address = params[:posting][:to_address]
    params[:posting][:from_address] = address_parameter_for_new("from_address")
    params[:posting][:to_address] = address_parameter_for_new("to_address")

    @posting = current_user.postings.new params[:posting]
    if @posting.save
      flash[:success] = "Ilan verildi"
      redirect_to share_posting_path(posting_id: @posting.id)
    else
      flash[:alert] = "Ilan verirken bir hata oluştu. Lütfen tekrar deneyin"
      redirect_to user_postings_path(current_user)
    end
  end
  
  def show
    @posting = Posting.find(params[:id])
    @user = User.find @posting.user_id
  end
  
  def find
    @driving = if params["/find_posting"].present? 
                params["/find_posting"][:driving] == "Farketmez" ? "" : params["/find_posting"][:driving]                
              end
    @from_address = address_parameter_for_search("from_address") if params["/find_posting"].present?
    @to_address = address_parameter_for_search("to_address")     if params["/find_posting"].present?

    @postings = params["/find_posting"].present? ? Posting.live_postings.with_from_address(@from_address).with_to_address(@to_address).with_driving(@driving) : Posting.live_postings
    
    @postings = @postings.paginate(page: params[:page], per_page: 10, order: "date asc") if @postings.present?
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
    @posting = Posting.find params[:posting_id]
    PostingMailer.posting_full(@posting.user_id, current_user.id, @posting.id).deliver
    flash[:success] = "Ilan dolu emaili yollandı"
    redirect_to user_path(current_user)
  end
  
  private
  
  def address_parameter_for_search(address)
    result = ""
    result += "#{params['/find_posting']["#{address}"][:neighborhood]}," if params['/find_posting']["#{address}"][:neighborhood].present?
    result += " #{params['/find_posting']["#{address}"][:district]}" if params['/find_posting']["#{address}"][:district].present?
    result.strip
  end
  
  def address_parameter_for_new(address)
    if params[:posting]["#{address}"][:district] == "Koc Universitesi"
      "Koc Universitesi"
    else 
      "#{params[:posting]["#{address}"][:neighborhood]}, #{params[:posting]["#{address}"][:district]}"
    end
  end
  
  def districts_and_driving_options
    @districts = District.pluck(:name).unshift("Koç Üniversitesi")
    @driving_options = %w(Farketmez Sürücü Yolcu Taksi)  
  end
  
end
