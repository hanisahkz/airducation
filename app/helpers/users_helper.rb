module UsersHelper

  #sept16 - defining current user is necessary.
  def current_user #coderwall
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


end
