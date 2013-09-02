class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_function :current_user, :logged_id?

  def current_user 
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def login(user)
    user.set_session_token!
    session[:session_token] = user.session_token
  end

  def logout(user)
    user.set_session_token!
    session[:session_token] = nil
  end

  def logged_in?
    !!@current_user
  end

end
