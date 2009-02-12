# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '2143c759e64cfef9a83980009251fee2'

  before_filter :authenticated?, :except => :login

  private

  def authenticated?
    unless logged_in?
      redirect_to(login_url)
    end
    
    User.current_user = current_user
  end

end
