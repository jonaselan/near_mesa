class ApplicationController < ActionController::API
  acts_as_token_authentication_handler_for User, fallback_to_devise: false
  respond_to :json
  protect_from_forgery with: :null_session
end
