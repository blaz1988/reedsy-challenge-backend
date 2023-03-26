# frozen_string_literal: true

class AuthenticationService
  def self.authenticate?(request)
    token = request.headers['Authorization']

    token.present? && token == ENV['AUTH_TOKEN']
  end
end
