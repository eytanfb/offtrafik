#!/bin/env ruby
# encoding: utf-8

class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :show]
  before_filter :correct_user, only: [:edit, :update]
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
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
  
  def activation
    guid = params[:a]
    user = User.find_by_activation_guid guid
    user.update_attribute(:active, 1)
    flash[:success] = "Uyeliginiz aktive edilmistir"
    sign_in user
    redirect_to user
  end
  
  def resend_activation
    @user = User.find params[:user_id]
    send_activation_email @user.id
    flash[:success] = "Aktivasyon maili yeniden yollandi"
    redirect_to root_path
  end
  
  def not_activated
    @user = User.find params[:user_id]
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
