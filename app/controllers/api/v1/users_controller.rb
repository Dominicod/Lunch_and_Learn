# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :require_api_key, only: %i[create login]
      def create
        user = User.create!(user_params)
        user.update(api_key: SecureRandom.hex(15))
        render json: UserSerializer.new(user), status: :created
      end

      def login
        user = User.find_by(email: user_params[:email])
        return unless user || user.authenticate(user_params[:password])

        user.update(api_key: SecureRandom.hex(15))
        render json: UserSerializer.new(user), status: :ok
      end

      def logout
        user = User.find_by(api_key: user_params[:api_key])
        user.update(api_key: nil)
        render json: UserSerializer.new(user), status: :ok
      end

      private

      def user_params
        params.permit(:name, :email.downcase, :password, :password_confirmation, :api_key)
      end
    end
  end
end
