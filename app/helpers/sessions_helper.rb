module SessionsHelper
  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    elsif cookies[:user_id]
      user = User.find(cookies[:user_id])

      if user && BCrypt::Password.new(user.remember_digest).is_password?(cookies[:remember_token])
          log_in user
          current_user = user
      end
    end
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    session.key?(:user_id)
  end

  def remember(user)
    remember_token = SecureRandom.urlsafe_base64

    user.remember(remember_token)

    cookies.permanent[:user_id] = user.id
    cookies.permanent[:remember_token] = remember_token
  end

  def forget(user)
    user.update(remember_digest: nil)

    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out(user)
    session.delete(:user_id)
    forget(user)
  end
end
