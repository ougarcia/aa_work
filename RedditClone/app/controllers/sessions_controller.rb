class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params)
    if @user
      login!(@user)
      redirect_to users_url
    else
      @user = User.new(user_params)
      flash.now[:errors] = "Invalid password/email combination"
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil
    redirect_to users_url
  end
end
