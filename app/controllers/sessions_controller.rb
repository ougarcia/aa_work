class SessionsController < ApplicationController
  before_action :logged_in, only: :new

  def create
    @user = User.find_by_credentials(user_params)

    if @user
      session[:session_token] = @user.reset_session_token!
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Try Again!"]
      @user = User.new(user_params)
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def destroy
    @user = User.find_by(session_token: session[:session_token])
    session[:session_controller] = nil
    @user.reset_session_token!
    redirect_to cats_url
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

  def logged_in
    if current_user && session[:session_token] == current_user.session_token
      redirect_to cats_url
    end
  end

end
