module SessionsHelper
  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
  end
  
  def current_user=(user)
    @current_user ||= user_from_remember_token
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  private
    def user_from_remember_token
	# the * operator allows us to use an array with two elements for a function that needs 2 arguments
      User.authenticate_with_salt(*remember_token)
    end
	
    def remember_token
	# returns an array with 2 elements: userId and salt
      cookies.signed[:remember_token] || [nil,nil]
    end
end