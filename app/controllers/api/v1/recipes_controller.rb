# frozen_string_literal: true

module Api
  module V1
    class RecipesController < ApplicationController
      before_action :random_country,
                    :require_api_key,
                    :valid_country_check,
                    only: [:index]
      def index
        render json: RecipeSerializer.new(RecipeFacade.create_recipes(query_params[:country]))
      end

      private

      def query_params
        params.permit(:country)
      end
    end
  end
end
