class CatRentalRequestsController < ApplicationController

  def index
    render json: Cat.find(params[:cat_id]).cat_rental_requests
  end

  def new
    if params[:cat_id].nil?
      @new_request = CatRentalRequest.new
    else
      @new_request = CatRentalRequest.new(cat_id: params[:cat_id])
      @cat = Cat.find(params[:cat_id])
    end
    @cats = Cat.all
    render :new
  end

  def create
    @new_request = CatRentalRequest.new(cat_rental_request_params)
    if @new_request.save
      redirect_to cat_rental_request_url(@new_request)
    else
      render :new
    end
  end

  def show
    @cat_rental_request = CatRentalRequest.find(params[:id])
    render json: @cat_rental_request
  end

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id)
  end

  def approve
    @request = CatRentalRequest.find(params[:id])
    @request.approve!
    redirect_to cat_url(@request.cat_id)
  end

  def deny
    @request = CatRentalRequest.find(params[:id])
    @request.approve! # deny!
    redirect_to cat_url(@request.cat_id)
  end

end
