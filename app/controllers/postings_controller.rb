class PostingsController < ApplicationController
  before_filter :signed_in_user, only: [:show, :share_posting]
  
  def new
    @posting = current_user.postings.new params[:posting]
  end
  
  def create
    @posting = current_user.postings.new params[:posting]
    if @posting.save
      flash[:success] = "Ilan verildi"
      redirect_to share_posting_path(posting_id: @posting.id)
    else
      render 'new'
    end
  end
  
  def show
    @posting = Posting.find(params[:id])
    @user = User.find_by_id @posting.user_id
  end
  
  def find
    @driving = "" if params["/find_posting"][:driving] == "Farketmez"
    @from_address = address_parameter_for_search("from_address") if params["/find_posting"].present?
    @to_address = address_parameter_for_search("to_address")     if params["/find_posting"].present?
    @postings = if params["/find_posting"].present?
      Posting.live_postings.search(@from_address, @to_address, @driving)
    else
      Posting.live_postings
    end
    @postings = @postings.paginate(page: params[:page], per_page: 10, order: "date asc") if @postings.present?
  end
  
  def share_posting
    @posting = Posting.find params[:posting_id]
  end
  
  def respond
    @posting = Posting.find params[:posting_id]
    PostingMailer.posting_contact(@posting.user_id, current_user.id, @posting.id).deliver
    flash[:success] = "Yanit isteginiz yollandi"
    redirect_to root_path
  end
  
  def full
    @posting = Posting.find params[:posting_id]
    PostingMailer.posting_full(@posting.user_id, current_user.id, @posting.id).deliver
    flash[:success] = "Ilan dolu emaili yollandi"
    redirect_to user_path(current_user)
  end
  
  private
  
  def address_parameter_for_search(address)
    result = ""
    result += "#{params['/find_posting']["#{address}"][:neighborhood]}," if params['/find_posting']["#{address}"][:neighborhood].present?
    result += " #{params['/find_posting']["#{address}"][:district]}," if params['/find_posting']["#{address}"][:district].present?
    result += " Istanbul" if params['/find_posting']["#{address}"][:neighborhood].present? || params['/find_posting']["#{address}"][:district].present?
    result
  end
  
end
