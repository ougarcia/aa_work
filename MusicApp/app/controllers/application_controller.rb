class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_in_user!(user)
    session[:session_token] = user.reset_session_token!
  end

  def log_out_user!(user)
    user.reset_session_token!
    session[:session_token] = nil
  end

  def make_sure_user_is_logged_in
    unless logged_in?
      redirect_to new_session_url
    end
  end

  def require_logout
    if logged_in?
      flash[:messages] = ["You're already logged in!"]
      redirect_to bands_url
    end
  end

end
