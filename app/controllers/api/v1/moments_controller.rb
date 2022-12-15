module Api
  module V1
    class MomentsController < ApplicationController
      def create
        moment = Moment.create(
          title: create_moment_params[:title],
          description: create_moment_params[:description],
          event_date: create_moment_params[:event_date],
          user_id: @current_user.id
        )

        if moment.valid?
          render json: moment, status: :ok
        else
          render json: { message: 'Something went wrong' }, status: :error
        end
      end

      def index
        render json: @current_user.moments.order(event_date: :desc), status: :ok
      end

      def destroy
        success = Moment.find(params[:id]).delete

        if success
          render json: { message: 'successfully deleted record' }
        else
          render json: { message: 'unable to delete record' }
        end
      end

      private

      def create_moment_params
        params.permit(%i[title description event_date])
      end
    end
  end
end
