# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Favorites | Create', type: :request do
  describe 'As a User, when I send a post request to /favorites' do
    let(:headers) { { CONTENT_TYPE: 'application/json' } }
    let(:user) { create(:user) }
    context('Happy Path') do
      describe 'and I send in the correct request body attributes' do
        let(:favorite) do
          {
            api_key: user.api_key,
            country: 'thailand',
            recipe_link: 'https://www.tastingtable.com/',
            recipe_title: 'Crab Fried Rice (Khaao Pad Bpu)'
          }
        end

        it 'creates a new favorite based on the sent in request body' do
          expect do
            post api_v1_favorites_path, headers: headers, params: JSON.generate(favorite)
          end.to change(Favorite, :count).by(+1)

          expect(response).to have_http_status :created
        end

        it 'after creation response has correct attributes' do
          post api_v1_favorites_path, headers: headers, params: JSON.generate(favorite)
          favorite_response = JSON.parse(response.body, symbolize_names: true)

          expect(favorite_response).to have_key :success
          expect(favorite_response[:success]).to eq 'Favorite added successfully'
        end

        it 'after creation the favorite is attached to the correct user' do
          post api_v1_favorites_path, headers: headers, params: JSON.generate(favorite)

          user_favorite = user.favorites.last

          expect(user_favorite.country).to eq 'thailand'
          expect(user_favorite.recipe_link).to eq 'https://www.tastingtable.com/'
          expect(user_favorite.recipe_title).to eq 'Crab Fried Rice (Khaao Pad Bpu)'
        end
      end
    end

    context('Edge Case') do
      describe 'and I do not send correct params' do
        let(:favorite) do
          {
            api_key: user.api_key,
            recipe_link: 'https://www.tastingtable.com/',
            recipe_title: 'Crab Fried Rice (Khaao Pad Bpu)'
          }
        end
        it "doesn't create a new favorite if correct params are missing" do
          expect do
            post api_v1_favorites_path, headers: headers, params: JSON.generate(favorite)
          end.to change(Favorite, :count).by(0)

          expect(response).to have_http_response :bad_request
        end

        it 'returns correct error message' do
          post api_v1_favorites_path, headers: headers, params: JSON.generate(favorite)
          error_response = JSON.parse(response.body, symbolize_names: true)

          expect(error_response).to have_key :errors
          expect(error_response[:errors][0][:status]).to eq 'Bad Request'
          expect(error_response[:errors][0][:message]).to eq 'param is missing or the value is empty: favorite'
          expect(error_response[:errors][0][:code]).to eq 400
        end
      end
      describe 'and I do not send API Key' do
        let(:favorite) do
          {
            country: 'thailand',
            recipe_link: 'https://www.tastingtable.com/',
            recipe_title: 'Crab Fried Rice (Khaao Pad Bpu)'
          }
        end

        it "doesn't create a new favorite if correct params are missing" do
          expect do
            post api_v1_favorites_path, headers: headers, params: JSON.generate(favorite)
          end.to change(Favorite, :count).by(0)

          expect(response).to have_http_response :unauthorized
        end

        it 'has correct attributes' do
          post api_v1_favorites_path, headers: headers, params: JSON.generate(favorite)
          error_response = JSON.parse(response.body, symbolize_name: true)

          expect(error_response[:errors]).to be_an Array
          expect(error_response[:errors][0][:status]).to eq 'Unauthorized'
          expect(error_response[:errors][0][:message]).to eq 'API Key Omitted or Invalid'
          expect(error_response[:errors][0][:code]).to eq 401
        end
      end
    end
  end
end
