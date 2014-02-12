#!/bin/env ruby
# encoding: utf-8

class UsersController < Devise::RegistrationsController
  before_filter :authenticate_user!, only: [:index, :edit, :update, :show]
  before_filter :notifications, except: [:enter_phone]
  
  def postings
    @live_postings = current_user.postings.live_postings.paginate(page: params[:live_postings_page], per_page: 5)
  end
  
  def past_postings
    @past_postings = current_user.postings.past_postings.paginate(page: params[:past_postings_page], per_page: 5)
  end
  
  def show
    @user = User.find(params[:id])
    @user.calculate_rating
    @agreed_journeys = @user.agreed_journeys.paginate(page: params[:journey_page], per_page: 3)
    @comments = Comment.find_all_by_is_about(@user.id).paginate(page: params[:comments_page], per_page: 3)
  end
  
  def find
    @users = User.find_all_by_name(params[:search_user])
  end
  
  def enter_phone
    if params[:enter_phone][:phone].present?
      current_user.update_attribute(:phone, params[:enter_phone][:phone])
    end
    redirect_to current_user
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
