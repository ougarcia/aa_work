class SessionsController < ApplicationController
  before_action :require_logout, only: [:new, :create]

  def new
    if logged_in?
      redirect_to user_url(current_user)
    else
      @user = User.new
    end
  end

  def create
    @user = User.find_by_credentials(user_params[:email], user_params[:password])
    if @user
      log_in_user!(@user)
      redirect_to user_url(@user)
    else
      @user = User.new(user_params)
      render :new
    end
  end

  def destroy
    @user = User.find_by(session_token: session[:session_token])
    log_out_user!(@user)
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
