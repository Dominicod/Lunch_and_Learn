# frozen_string_literal: true

module Api
  module V1
    class LearningResourcesController < ApplicationController
      def index

      end

      private

      def query_params
        params.permit(:country)
      end
    end
  end
end
