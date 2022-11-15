# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :require_api_key, :require_user
      def create
        user = User.create!(user_params)
        render json: UserSerializer.new(user), status: :created
      end

      private

      def user_params
        params.require(:user)
              .permit(:name, :email.downcase, :password, :password_confirmation)
              .with_defaults(api_key: SecureRandom.hex(15))
      end
    end
  end
end
