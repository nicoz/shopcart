module SessionsHelper

  def sign_in( user )
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.hash(remember_token))
    self.current_user = user
  end
  
  def social_sign_in( social_user )
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    social_user.user.update_attribute(:remember_token, User.hash(remember_token))
    cookies.permanent[:social_id] = social_user.social_id
    cookies.permanent[:service_id] = social_user.service_id
    self.current_user = social_user.user
    self.social_user = social_user
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    remember_token = User.hash(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end
  
  def current_social_user?(user)
    user == social_user
  end
  
   def social_user=(user)
    @social_user = user
  end
  
  def current_social_user
    @social_user ||= SocialUser.find_by(social_id: cookies[:social_id], 
    service_id: cookies[:service_id])
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def admin?
    current_user.admin
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.hash(User.new_remember_token))
    cookies.delete(:remember_token)
    cookies.delete(:social_id)
    cookies.delete(:service_id)
    self.current_user = nil
    self.social_user = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
end
