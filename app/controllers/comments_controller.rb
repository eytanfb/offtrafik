class CommentsController < ApplicationController
  
  def new
    @comment = Comment.new
  end
  
  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      flash[:success] = "Yorum Yapildi"
      redirect_to @comment
    else
      render 'new'
    end
  end
  
  def show
    @comment = Comment.find(params[:id])
  end
  
end
