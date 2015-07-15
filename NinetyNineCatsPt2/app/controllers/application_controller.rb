class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    session = current_session
    if session
      @current_user ||= User.find(session.user_id)
    else
      nil
    end
  end

  def log_in!(user)
    new_token = Session.new_token
    Session.create!(user_id: user.id, session_token: new_token)
    session[:session_token] = new_token
  end

  def log_out!(user)
    current_token = session[:session_token]
    current_session = Session.find_by_session_token(current_token)
    current_session.destroy
    session[:session_token] = nil
  end

  def validate_not_logged_in
    redirect_to cats_url if current_user
  end


  def current_session
    Session.find_by_session_token(session[:session_token])
  end



end
