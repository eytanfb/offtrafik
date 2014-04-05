#!/bin/env ruby
# encoding: utf-8

class UsersController < Devise::RegistrationsController
  before_filter :authenticate_user!, only: [:index, :edit, :update, :show]
  before_filter :notifications, except: [:enter_phone]
  before_filter :get_past_responses, except: [:enter_phone]
  
  def postings
    @live_postings = current_user.postings.live_postings.includes(:user).paginate(page: params[:page], per_page: 9)
  end
  
  def past_postings
    @past_postings = current_user.postings.past_postings.includes(:user).paginate(page: params[:page], per_page: 9)
  end
  
  def show
    @user = User.find(params[:id])
    @user.calculate_rating
    @agreed_journeys = @user.agreed_journeys.paginate(page: params[:journey_page], per_page: 3)
    @comments = Comment.includes(:user).find_all_by_is_about(@user.id).paginate(page: params[:comments_page], per_page: 3)
  end
  
  def find
    @users = User.find_all_by_name(params[:search_user])
  end
  
  def update
    @user = User.find current_user.id

    successfully_updated = unless params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      @user.update_with_password params[:user]
    else
      params[:user].delete :password
      params[:user].delete :current_password
      @user.update_without_password params[:user]
    end

    if successfully_updated
      set_flash_message :notice, :updated
      sign_in @user, bypass: true
      redirect_to after_update_path_for @user
    else
      render "edit"
    end
  end
  
  protected

  def after_update_path_for(resource)
    user_path resource
  end
  
  def after_inactive_sign_up_path_for(resource)
    find_posting_path
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
