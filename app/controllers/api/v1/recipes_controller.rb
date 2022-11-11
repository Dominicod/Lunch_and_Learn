# frozen_string_literal: true

module Api
  module V1
    class RecipesController < ApplicationController
      def show
        render json: RecipeSerializer.new(RecipeFacade.create_recipes(country_params))
      end

      private

      def country_params
        params.permit(:country)
      end
    end
  end
end
