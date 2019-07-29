module Authenticate
  def current_user
    auth_token = request.headers["AUTH-TOKEN"]

    return @current_user = User.find_by(authentication_token: auth_token) if auth_token.present?
  end

  def authenticate_with_token!
    return if current_user

    json_response 'Unauthenticated', false, {}, :unauthorized
  end

  def correct_user(user)
    user.id == current_user.id
  end

  def invalid_user(user)
    user.id != current_user.id
  end
end