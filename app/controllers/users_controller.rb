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
    @postings = @user.postings.paginate(page: params[:page], per_page: 2, order: "date ASC")
    @comments = Comment.find_all_by_is_about(@user.id).paginate(page: params[:page], per_page: 5)
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Koç Carpool Projesine Hoşgeldin!" # Welcome to The Koc Carpool Project      
      redirect_to @user
    else
      @communication_options = { "Email" => "email", "Telefon" => "phone", "BBM" => "bbm" }
      render 'new'
    end
  end
  
  def new
    @user = User.new
    @communication_options = { "Email" => "email", "Telefon" => "phone", "BBM" => "bbm" }
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile Updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
  
end
