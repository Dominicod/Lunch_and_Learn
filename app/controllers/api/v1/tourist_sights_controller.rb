# frozen_string_literal: true

module Api
  module V1
    class TouristSightsController < ApplicationController # rubocop:todo Style/Documentation
      before_action :random_country, only: [:index]
      def index
        render json: TouristSightSerializer.new(TourismSightFacade.create_sights(sight_params[:country]))
      end

      private

      def sight_params
        params.permit(:country)
      end
    end
  end
end
