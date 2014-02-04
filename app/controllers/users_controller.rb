#!/bin/env ruby
# encoding: utf-8

class UsersController < Devise::RegistrationsController
  before_filter :authenticate_user!, only: [:index, :edit, :update, :show]
  
  def postings
    @live_postings = current_user.postings.live_postings.paginate(page: params[:live_postings_page], per_page: 5)
  end
  
  def past_postings
    @past_postings = current_user.postings.past_postings.paginate(page: params[:past_postings_page], per_page: 5)
  end
  
  def show
    @user = User.find(params[:id])
    @user.calculate_rating
    @postings = @user.postings.paginate(page: params[:page], per_page: 2, order: "date ASC")
    @comments = Comment.find_all_by_is_about(@user.id).paginate(page: params[:page], per_page: 5)
    @favorites = @user.favorites
  end
  
  def find
    @users = User.find_all_by_name(params[:search_user])
  end
  
  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def send_activation_email(id)
      UserMailer.activation(id).deliver
    end
  
end
