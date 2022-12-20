class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    if request.headers['Authorization'].present?
      token = request.headers['Authorization'].split.last
      begin
        decoded_token = JWT.decode(token, ENV['JWT_SECRET'])
        @current_user = User.find(decoded_token.first['user_id'])
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      end
    else
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
    end
  end
end
