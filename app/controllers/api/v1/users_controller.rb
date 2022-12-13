module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_request, only: :create

      def create
        user = User.new(user_params)
        if user.save
          # i wanted to include the jwt response in the user obj, unsure if this is worth keeping
          token = JWT.encode({ user_id: user.id }, ENV['JWT_SECRET'], 'HS256')

          json_user = user.as_json
          json_user['token'] = token

          render json: { user: json_user }, status: :created
        else
          render json: { errors: user.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.except(:format).permit(%i[email password first_name last_name username])
      end
    end
  end
end
