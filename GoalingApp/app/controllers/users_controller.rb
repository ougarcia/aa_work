class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @goals = @user.goals
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to @user
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

end
