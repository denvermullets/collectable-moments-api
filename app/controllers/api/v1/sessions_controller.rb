module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authenticate_request, only: :create

      def create
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
          payload = { user_id: user.id }
          token = JWT.encode(payload, ENV['JWT_SECRET'])

          json_user = user.as_json
          json_user['token'] = token

          render json: { user: json_user }, status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end
    end
  end
end
