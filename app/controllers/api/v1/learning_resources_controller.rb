# frozen_string_literal: true

module Api
  module V1
    class LearningResourcesController < ApplicationController
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
