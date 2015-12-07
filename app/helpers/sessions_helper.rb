module SessionsHelper

  # Logs in the given user.  Will pop session cookie upon browser close.
  # Apparently, the session helper is secure and not susceptible to session hijacking.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end