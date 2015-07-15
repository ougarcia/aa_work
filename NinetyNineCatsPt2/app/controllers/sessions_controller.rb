class SessionsController < ApplicationController
  before_action :validate_not_logged_in, only: :new

  def create
    @user = User.find_by_credentials(user_params)

    if @user
      log_in!(@user)
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
    @user = current_session.user
    log_out!(@user)
    redirect_to cats_url
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
