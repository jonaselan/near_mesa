module AuthHelpers
  def auth_token_to_headers(user)
    default_headers
    request.headers['X-User-Email'] = user.email.to_s
    request.headers['X-User-Token'] = user.authentication_token.to_s
  end

  def clear_auth_token
    default_headers
    request.headers['X-User-Email'] = nil
    request.headers['X-User-Token'] = nil
  end

  def default_headers
    request.headers['Accept'] = 'application/json'
    request.headers['Content-Type'] = 'application/json'
  end
end

RSpec.configure do |config|
  config.include AuthHelpers, type: :controller
end
