class CarsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  
  def create
    @car = current_user.cars.build(params[:car])
    if @car.save
      flash[:success] = "Araba Kaydedildi"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end
  
  def destroy
    
  end
end