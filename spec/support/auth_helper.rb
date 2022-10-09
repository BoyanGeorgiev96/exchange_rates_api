# frozen_string_literal: true

module AuthHelper
  def auth_header
    token = JsonWebToken.encode(user_id: 1)
    { 'Authorization': "Bearer #{token}" }
  end

  def invalid_auth
    token = JsonWebToken.encode(user_id: '4')
    { 'Authorization': "Bearer #{token}" }
  end

  def json(response)
    JSON.parse(response.body)
  end
end
