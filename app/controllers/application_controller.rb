class ApplicationController < ActionController::Base
  protect_from_forgery

	#before_filter :require_login         #for devise
  before_filter :authenticate_user!

private

  def is_admin?
    if !current_user.admin?
      redirect_to :back
    end
  end
  
end

 
