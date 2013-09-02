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
    @postings = Posting.search(params[:from_address], params[:to_address], Date.today, params[:driving]).paginate(page: params[:page], per_page: 10, order: "date ASC")
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
  
end
