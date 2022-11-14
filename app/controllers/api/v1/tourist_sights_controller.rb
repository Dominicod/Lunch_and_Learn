# frozen_string_literal: true

module Api
  module V1
    class TouristSightsController < ApplicationController # rubocop:todo Style/Documentation
      before_action :random_country, only: [:index]
      def index
        tourism_sights = TourismSightFacade.create_sights(sight_params[:country])
        raise IncorrectEmailException, "Country invalid for: #{sight_params[:country]}" unless tourism_sights.is_a?(Array)

        render json: TouristSightSerializer.new(tourism_sights)
      end

      private

      def sight_params
        params.permit(:country)
      end
    end
  end
end
