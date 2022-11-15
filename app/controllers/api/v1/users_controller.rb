# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :require_api_key, only: [:create, :login]
      def create
        user = User.create!(user_params)
        render json: UserSerializer.new(user), status: :created
      end

      def login
        user = User.find_by(email: user_params[:email])
        return unless user.authenticate(user_params[:password])

        user.update!(api_key: user_params[:api_key])
        render json: UserSerializer.new(user), status: :ok
      end

      def logout
        user = User.find_by(api_key: user_params[:api_key])
        user.update(api_key: nil)
        render json: UserSerializer.new(user), status: :ok
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
