class CommentsController < ApplicationController
  before_filter :signed_in_user, only: [:create]
  
  def new
    if params[:is_about]
      @comment = Comment.new
      @is_about = params[:is_about]
    else
      redirect_to current_user
      flash[:warning] = "Yorum yapmak icin once yorum yapmak istediginiz kullanicinin sayfasina gidiniz"
    end
  end
  
  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      flash[:success] = "Yorum Yapildi"
      redirect_to current_user
    else
      render 'new'
    end
  end
  
end
