class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(user_params)
    if @user
      log_in(@user)
      redirect_to root_url
    else
      flash.now[:errors] = "Invalid login."
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
