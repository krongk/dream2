# Be sure to restart your server when you modify this file.

Laopo::Application.config.session_store :cookie_store, :key => '_laopo_session'

#Laopo::Application.config.session_store :expire_after => 1.minutes.from_now
#ActionController::Base.session_options[:session_expires] = 1.minutes.from_now

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# Laopo::Application.config.session_store :active_record_store
