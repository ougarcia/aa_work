class UsersController < ApplicationController
  before_action :logged_in, only: [:new]


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:session_token] = @user.reset_session_token!
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end


  def user_params
    params.require(:user).permit(:username, :password)
  end

  def logged_in
    if current_user && session[:session_token] == current_user.session_token
      redirect_to cats_url
    end
  end

end
