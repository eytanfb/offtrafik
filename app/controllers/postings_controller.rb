# encoding: utf-8

class PostingsController < ApplicationController
  before_filter :signed_in_user, only: [:show, :share_posting, :full, :respond]
  before_filter :districts_and_driving_options, only: [:new, :find, :find_from_home_page]
  
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
    to_address = @posting.format(@posting.to_address)
    from_address = @posting.format(@posting.from_address)
    @to_from = "#{to_address} - #{from_address}"
    @message = "
#{@user.name} seninle #{@posting.formatted_date} tarihinde yapacagin #{@to_from} yolculugu icin irtibata gecmek istiyor.

Eger hala trafikten kurtulacak birini ariyorsan tikla.

Eger yol arkadaslarini bulduysan, lutfen buraya tikla.

#{@user.name}"
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
    PostingMailer.posting_full(posting.user_id, params[:responder_id], @posting.id).deliver
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
    if params[:posting]["#{address}"][:district] == "Koç Üniversitesi"
      "Koç Üniversitesi"
    else 
      "#{params[:posting]["#{address}"][:neighborhood]}, #{params[:posting]["#{address}"][:district]}"
    end
  end
  
  def districts_and_driving_options
    @districts = District.pluck(:name).unshift("Koç Üniversitesi")
    @driving_options = %w(Farketmez Sürücü Yolcu Taksi)  
  end
  
end
