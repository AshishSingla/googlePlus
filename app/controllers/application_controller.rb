class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?

  def current_user
    u = nil
    if !!session[:user_id]
      begin
        #session[:user_id]=32546546
        u = User.find(session[:user_id])
      rescue ActiveRecord::RecordNotFound => e
        session[:user_id] = nil
      end
    end
    u
  end

  def logged_in?
    !!current_user
  end
end
