# frozen_string_literal: true

module Api
  module V1
    class LearningResourcesController < ApplicationController
      before_action :require_api_key
      def index
        render json: LearningResourceSerializer.new(
          LearningResourceFacade.create_learning_resource(query_params[:country])
        )
      end

      private

      def query_params
        params.permit(:country)
      end
    end
  end
end
