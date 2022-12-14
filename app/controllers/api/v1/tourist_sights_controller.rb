# frozen_string_literal: true

module Api
  module V1
    class TouristSightsController < ApplicationController
      before_action :random_country,
                    :valid_country_check,
                    :require_api_key,
                    only: [:index]
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
