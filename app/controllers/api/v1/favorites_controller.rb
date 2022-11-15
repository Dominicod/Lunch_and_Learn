# frozen_string_literal: true

module Api
  module V1
    class FavoritesController < ApplicationController
      before_action :require_api_key
      def create
        user = User.find_by(api_key: params[:api_key])
        user.favorites.create!(favorite_params)
        render json: { success: 'Favorite added successfully' }, status: :created
      end

      private

      def favorite_params
        params.permit(:country, :recipe_link, :recipe_title)
      end
    end
  end
end
