# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users | Logout', type: :request do
  describe 'As a User, when I send a post request to /users/logout' do
    let(:headers) { { CONTENT_TYPE: 'application/json' } }
    let(:user) { create(:user) }
    context('Happy Path') do
      describe 'and I send in the correct request body attributes to logout' do

        it 'returns valid response' do
          post api_v1_users_logout_path, headers: headers, params: JSON.generate(api_key: user.api_key)

          expect(response).to have_http_status :ok
        end

        it 'returns correct attributes in response' do
          post api_v1_users_logout_path, headers: headers, params: JSON.generate(api_key: user.api_key)
          user_response = JSON.parse(response.body, symbolize_names: true)

          expect(user_response).to have_key :data
          expect(user_response.dig(:data, :type)).to eq 'user'
          expect(user_response[:data]).to have_key :id
          expect(user_response[:data]).to have_key :attributes
          expect(user_response.dig(:data, :attributes, :name)).to eq user[:name]
          expect(user_response.dig(:data, :attributes, :email)).to eq user[:email]
          expect(user_response.dig(:data, :attributes, :api_key)).to eq nil
        end
      end
    end

    context('Edge Case') do
      describe 'and I send in the incorrect request body attributes' do
        it 'returns a 401 auth error if API key is omitted' do
          post api_v1_users_logout_path, headers: headers, params: JSON.generate({})

          expect(response).to have_http_status :unauthorized
        end

        it 'returns correct error message' do
          post api_v1_users_logout_path, headers: headers, params: JSON.generate({})

          error_response = JSON.parse(response.body, symbolize_names: true)

          expect(error_response[:errors]).to be_an Array
          expect(error_response[:errors][0][:status]).to eq 'Unauthorized'
          expect(error_response[:errors][0][:message]).to eq 'API Key Omitted or Invalid'
          expect(error_response[:errors][0][:code]).to eq 401
        end

        it 'returns a 401 auth error if API key is invalid' do
          post api_v1_users_logout_path, headers: headers, params: JSON.generate(api_key: 'not correct')

          expect(response).to have_http_status :unauthorized
        end

        it 'returns correct error message' do
          post api_v1_users_logout_path, headers: headers, params: JSON.generate(api_key: 'not correct')

          error_response = JSON.parse(response.body, symbolize_names: true)

          expect(error_response[:errors]).to be_an Array
          expect(error_response[:errors][0][:status]).to eq 'Unauthorized'
          expect(error_response[:errors][0][:message]).to eq 'API Key Omitted or Invalid'
          expect(error_response[:errors][0][:code]).to eq 401
        end
      end
    end
  end
end
