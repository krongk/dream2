require "authenticated_system"
class ApplicationController < ActionController::Base
  protect_from_forgery
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  has_mobile_fu 
end

$SITE_URL =  "/" || "http://dream2.heroku.com/"