# frozen_string_literal: true

module Api
  module V1
    class RecipesController < ApplicationController # rubocop:todo Style/Documentation
      before_action :random_country, only: [:index]
      def index
        recipes = RecipeFacade.create_recipes(query_params[:country])
        raise IncorrectCountryException, "Country invalid for: #{query_params[:country]}" unless recipes.is_a?(Array)

        render json: RecipeSerializer.new(recipes)
      end

      private

      def query_params
        params.permit(:country)
      end
    end
  end
end
