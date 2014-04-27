class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [:create]
  before_filter :notifications, except: [:create]
  
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
    @comment = current_user.comments.new(params[:comment])
    if @comment.save
      Rails.cache.delete "users/#{params[:comment][:is_about]}/rating"
      flash[:success] = "Yorum Yapildi"
      redirect_to User.find(params[:comment][:is_about])
    else
      render 'new'
    end
  end
  
  def show
    @comment = Comment.find params[:id]
  end
end
