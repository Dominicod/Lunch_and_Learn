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
          expect(user_response[:type]).to eq 'user'
          expect(user_response).to have_key :id
          expect(user_response).to have_key :attributes
          expect(user_response[:attributes][:name]).to eq user[:name]
          expect(user_response[:attributes][:email]).to eq user[:email]
          expect(user_response[:attributes][:api_key]).to be_an String
        end
      end
    end
  end
end
