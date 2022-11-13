# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users | Create', type: :request do
  describe 'As a new User, when I send a post request to /users' do
    context('Happy Path') do
      describe 'and I send in the correct request body attributes' do
        let(:user) do
          {
            "name": 'Athena Dao',
            "email": 'athenadao@bestgirlever.com',
            "password": 'password',
            "password_confirmation": 'password'
          }
        end
        let(:headers) { { CONTENT_TYPE: 'application/json' } }

        it 'creates a new user based on the sent in request body' do
          expect do
            post api_v1_users_path, headers: headers, params: JSON.generate(user: user)
          end.to change(User, :count).by(+1)

          expect(response).to have_http_status :created
        end

        it 'after creation user has correct attributes' do
          post api_v1_users_path, headers: headers, params: JSON.generate(user: user)
          user_response = JSON.parse(response.body, symbolize_names: true)

          expect(user_response).to have_key :data
          expect(user_response.dig(:data, :type)).to eq 'user'
          expect(user_response[:data]).to have_key :id
          expect(user_response[:data]).to have_key :attributes
          expect(user_response.dig(:data, :attributes, :name)).to eq user[:name]
          expect(user_response.dig(:data, :attributes, :email)).to eq user[:email]
          expect(user_response.dig(:data, :attributes, :api_key)).to be_an String
        end
      end
    end
    context('Sad Path') do
      describe 'and I send in the correct request body attributes' do
        let(:user) do
          {
            "name": 'Athena Dao',
            "email": 'athenadao@bestgirlever.com',
            "password": 'password',
            "password_confirmation": 'password'
          }
        end
        let(:headers) { { CONTENT_TYPE: 'application/json' } }

        it "doesn't create a new user if email already exists" do
          post api_v1_users_path, headers: headers, params: JSON.generate(user: user)

          expect do
            post api_v1_users_path, headers: headers, params: JSON.generate(user: user)
          end.to change(User, :count).by(0)
        end

        it 'returns correct error message' do
          post api_v1_users_path, headers: headers, params: JSON.generate(user: user)
          post api_v1_users_path, headers: headers, params: JSON.generate(user: user)

          expect(response).to have_http_status :unprocessable_entity

          error_response = JSON.parse(response.body, symbolize_names: true)

          expect(error_response).to have_key :errors
          expect(error_response.dig(:errors, :status)).to eq 'Unprocessable Entity'
          expect(error_response.dig(:errors, :message)).to eq 'Validation failed: Email has already been taken'
          expect(error_response.dig(:errors, :code)).to eq 422
        end
      end
    end
  end
end
