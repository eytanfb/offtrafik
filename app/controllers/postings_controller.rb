class PostingsController < ApplicationController
  before_filter :signed_in_user, only: [:show, :share_posting]
  
  def new
    @posting = current_user.postings.new params[:posting]
  end
  
  def create
    @posting = current_user.postings.new params[:posting]
    if @posting.save
      flash[:success] = "Ilan verildi"
      redirect_to share_posting_path
    else
      flash[:warning] = "Ilan Verilemedi"
      redirect_to share_posting_path
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
    @posting = current_user.postings.last
  end
  
end
