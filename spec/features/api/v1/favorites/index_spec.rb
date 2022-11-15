# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Favorites | Index', type: :request do
  describe 'As a User, when I send a get request to /favorites' do
    let!(:user) do
      @user = create(:user)
      create_list(:favorite, 2, user_id: @user.id)
    end
    context('Happy Path') do
      describe 'and I send in the correct request body attributes' do
        it 'shows a index of favorite based on the API Key' do
          get api_v1_favorites_path, params: { api_key: @user.api_key }

          expect(response).to have_http_status :ok
        end

        it 'shows all listed user favorites' do
          get api_v1_favorites_path, params: { api_key: @user.api_key }
          favorite_response = JSON.parse(response.body, symbolize_names: true)

          expect(favorite_response[:data].count).to eq 2
          expect(favorite_response[:data]).to all(have_key(:id))
          expect(favorite_response[:data]).to all(have_key(:attributes))
          expect(favorite_response[:data][0][:attributes]).to have_key(:country)
          expect(favorite_response[:data][0][:attributes]).to have_key(:recipe_link)
          expect(favorite_response[:data][0][:attributes]).to have_key(:recipe_title)
        end
      end
    end

    context('Edge Case') do
      describe 'and I do not send API Key' do
        it "doesn't list favorites if correct params are missing" do
          get api_v1_favorites_path, params: {}

          expect(response).to have_http_status :unauthorized
        end

        it 'has correct attributes' do
          get api_v1_favorites_path, params: {}
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
