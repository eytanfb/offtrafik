#!/bin/env ruby
# encoding: utf-8

class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :show]
  before_filter :correct_user, only: [:edit, :update]
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @user.calculate_rating
    @postings = @user.postings.paginate(page: params[:page], per_page: 2, order: "date ASC")
    @comments = Comment.find_all_by_is_about(@user.id).paginate(page: params[:page], per_page: 5)
    @favorites = @user.favorites
  end
  
  def create
    @user = User.new(params[:user])
    @user.activation_guid = SecureRandom.urlsafe_base64
    if @user.save
      sign_in @user
      flash[:success] = "Offtrafik'e Hoşgeldin!"
      redirect_to @user
    else
      @communication_options = { "Email" => "email", "Telefon" => "phone", "BBM" => "bbm" }
      render 'new'
    end
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profil Güncellendi"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def find
    @users = User.find_all_by_name(params[:search_user])
  end
  
  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
  
end
