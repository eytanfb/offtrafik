#!/bin/env ruby
# encoding: utf-8

class UsersController < Devise::RegistrationsController
  before_filter :authenticate_user!, only: [:index, :edit, :update, :show]
  before_filter :notifications, except: [:enter_phone]
  
  def postings
    @live_postings = current_user.postings.live_postings.includes(:user).paginate(page: params[:page], per_page: 6)
  end
  
  def past_postings
    @past_postings = current_user.postings.past_postings.includes(:user).paginate(page: params[:page], per_page: 6)
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
  
  def enter_phone
    if params[:enter_phone][:phone].present?
      current_user.update_attribute(:phone, params[:enter_phone][:phone])
    end
    @posting_response = PostingResponse.find params[:posting_response]
    PostingResponseMailer.accepted_to_owner(current_user.id, @posting_response.responder.id, @posting_response.posting.id).deliver
    PostingResponseMailer.accepted_to_responder(current_user.id, @posting_response.responder.id, @posting_response.posting.id).deliver
    redirect_to @posting_response.posting
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
  
  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def send_activation_email(id)
      UserMailer.activation(id).deliver
    end
  
end
