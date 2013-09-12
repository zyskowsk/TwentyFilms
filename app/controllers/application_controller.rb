class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?

  def current_user 
    @current_user ||= User.find_by_session_token(session[:session_token])
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def login!(user)
    user.set_session_token!
    session[:session_token] = user.session_token
  end

  def logout!(user)
    user.set_session_token!
    session[:session_token] = nil if session[:session_token]
    session[:user_id] = nil if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def notices
    flash[:notices] ||= []
  end

  def now_notices
    flash.now[:notices] ||= []
  end

end
