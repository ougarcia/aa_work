class SubsController < ApplicationController
  before_action :redirect_if_not_moderator, only: [:edit, :update, :destroy]

  def index
    @subs = Sub.all
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator = current_user
    if @sub.save
      flash[:notice] = "Sub Created!"
      redirect_to @sub
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub && @sub.update(sub_params)
      flash[:notice] = "Sub Updated!"
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def show
    @sub = Sub.includes(:posts).find(params[:id])
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    redirect_to subs_url
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def redirect_if_not_moderator
    current_sub = Sub.find(params[:id])
    if current_user != current_sub.moderator
      redirect_to current_sub
    end
  end

end
