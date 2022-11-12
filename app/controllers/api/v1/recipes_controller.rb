# frozen_string_literal: true

module Api
  module V1
    class RecipesController < ApplicationController
      before_action :random_country, only: [:index]
      def index
        render json: RecipeSerializer.new(RecipeFacade.create_recipes(query_params[:country]))
      end

      private

      def query_params
        params.permit(:country)
      end

      def random_country
        params[:country] = CountryFacade.random_country.name if params[:country].nil?
      end
    end
  end
end
