class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user

  def logged_in?
    !!session[:user_id]
  end

  def require_logout
    redirect_to root_path, error: "You're already logged in!" unless !logged_in?
  end

  def require_login
    redirect_to login_path, error: "You're already logged in!" unless logged_in?
  end

  def current_user
    @current_user ||= User.find session[:user_id] if logged_in?
  end
end
