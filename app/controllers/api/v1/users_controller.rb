# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def create
        render json: UserSerializer.new()
      end
    end
  end
end
