# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users | Login', type: :request do
  describe 'As a User, when I send a post request to /users/login' do
    let(:headers) { { CONTENT_TYPE: 'application/json' } }
    let!(:user_create) do
      user = {
        name: 'admin',
        password: 'password',
        password_confirmation: 'password',
        email: 'admin@gmail.com'
      }
      post api_v1_users_path, headers: headers, params: JSON.generate(user)
      JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    end
    context('Happy Path') do
      describe 'and I send in the correct request body attributes to login' do
        it 'returns valid response' do
          user = {
            email: 'admin@gmail.com',
            password: 'password'
          }
          post api_v1_users_login_path, headers: headers,
                                        params: JSON.generate(user)

          expect(response).to have_http_status :ok
        end

        it 'returns correct attributes in response' do
          user = {
            email: 'admin@gmail.com',
            password: 'password'
          }
          post api_v1_users_login_path, headers: headers,
                                        params: JSON.generate(user)

          user_response = JSON.parse(response.body, symbolize_names: true)

          expect(user_response).to have_key :data
          expect(user_response.dig(:data, :type)).to eq 'user'
          expect(user_response[:data]).to have_key :id
          expect(user_response[:data]).to have_key :attributes
          expect(user_response.dig(:data, :attributes, :name)).to eq user_create[:name]
          expect(user_response.dig(:data, :attributes, :email)).to eq user_create[:email]
          expect(user_response.dig(:data, :attributes, :api_key)).to be_an String
        end
      end
    end

    context('Edge Case') do
      describe 'and I send in the incorrect request body attributes' do
        it 'returns a 401 auth error if email is incorrect' do
          user = {
            password: 'password'
          }
          post api_v1_users_login_path, headers: headers,
                                        params: JSON.generate(user)

          expect(response).to have_http_status :unauthorized
        end

        it 'returns correct error message' do
          user = {
            password: 'password'
          }
          post api_v1_users_login_path, headers: headers,
                                        params: JSON.generate(user)

          error_response = JSON.parse(response.body, symbolize_names: true)

          expect(error_response[:errors]).to be_an Array
          expect(error_response[:errors][0][:status]).to eq 'Unauthorized'
          expect(error_response[:errors][0][:message]).to eq 'Verification Failed'
          expect(error_response[:errors][0][:code]).to eq 401
        end

        it 'returns a 401 auth error if password is incorrect' do
          user = {
            email: 'admin@gmail.com',
            password: 'notcorrect'
          }
          post api_v1_users_login_path, headers: headers,
                                        params: JSON.generate(user)

          expect(response).to have_http_status :unauthorized
        end

        it 'returns correct error message' do
          user = {
            email: 'admin@gmail.com',
            password: 'notcorrect'
          }
          post api_v1_users_login_path, headers: headers,
                                        params: JSON.generate(user)

          error_response = JSON.parse(response.body, symbolize_names: true)

          expect(error_response[:errors]).to be_an Array
          expect(error_response[:errors][0][:status]).to eq 'Unauthorized'
          expect(error_response[:errors][0][:message]).to eq 'Verification Failed'
          expect(error_response[:errors][0][:code]).to eq 401
        end
      end
    end
  end
end
