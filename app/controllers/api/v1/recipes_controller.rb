# frozen_string_literal: true

module Api
  module V1
    class RecipesController < ApplicationController
      def index
        recipes = RecipeFacade.create_recipes(country_params)

        render json: RecipeSerializer.new(recipes) if recipes
        render json: { data: [] } unless recipes
      end

      private

      def country_params
        params.permit(:country)
      end
    end
  end
end
