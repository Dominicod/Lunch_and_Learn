# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recipes | Index', :vcr, type: :request do
  describe 'As a User, when I visit /recipes and then enter the query param of a country' do
    context('Happy Path') do
      describe 'I enter ?country=thailand and then it' do
        let!(:recipes_response) do
          get api_v1_recipes_path, params: { country: 'thailand', api_key: '12345' }
          JSON.parse(response.body, symbolize_names: true)
        end

        it { expect(response).to have_http_status :ok }

        it 'has correct attributes' do
          expect(recipes_response[:data]).to all(have_key(:id))
          expect(recipes_response[:data]).to all(have_key(:attributes))
          expect(recipes_response[:data][0][:attributes]).to have_key(:title)
          expect(recipes_response[:data][0][:attributes]).to have_key(:url)
          expect(recipes_response[:data][0][:attributes]).to have_key(:country)
          expect(recipes_response[:data][0][:attributes]).to have_key(:image)
          expect(recipes_response[:data][0][:attributes]).not_to have_key(:images)
          expect(recipes_response[:data][0][:attributes]).not_to have_key(:health_labels)
          expect(recipes_response[:data][0][:attributes]).not_to have_key(:cautions)
        end
      end
    end

    context('Sad Path') do
      describe 'I enter ?country=Djibouti and then it' do
        let!(:recipes_response) do
          get api_v1_recipes_path, params: { country: 'Djibouti', api_key: '12345' }
          JSON.parse(response.body, symbolize_names: true)
        end

        it { expect(response).to have_http_status :ok }

        it 'returns empty array if country has no recipes' do
          expect(recipes_response).to have_key(:data)
          expect(recipes_response[:data]).to eq []
        end

        it 'returns empty array if no string passed to param' do
          get api_v1_recipes_path, params: { country: '', api_key: '12345' }
          response_recipe = JSON.parse(response.body, symbolize_names: true)

          expect(response_recipe).to have_key(:data)
          expect(response_recipe[:data]).to eq []
        end
      end

      describe 'I do not enter a query param for country and then it' do
        let!(:recipes_response) do
          mocked_country = Country.new({ name: { common: 'Laos' } })
          allow(CountryFacade).to receive(:random_country).and_return(mocked_country)
          get api_v1_recipes_path, params: { api_key: '12345' }
          JSON.parse(response.body, symbolize_names: true)
        end

        it { expect(response).to have_http_status :ok }

        it 'returns random country and has correct attributes' do
          expect(recipes_response[:data]).to all(have_key(:id))
          expect(recipes_response[:data]).to all(have_key(:attributes))
          expect(recipes_response[:data][0][:attributes]).to have_key(:title)
          expect(recipes_response[:data][0][:attributes]).to have_key(:url)
          expect(recipes_response[:data][0][:attributes]).to have_key(:country)
          expect(recipes_response[:data][0][:attributes]).to have_key(:image)
          expect(recipes_response[:data][0][:attributes]).not_to have_key(:images)
          expect(recipes_response[:data][0][:attributes]).not_to have_key(:health_labels)
          expect(recipes_response[:data][0][:attributes]).not_to have_key(:cautions)
        end
      end
    end

    context('Edge Case') do
      describe 'and then I insert a non-ASCII supported list of characters into params (Edge Case)' do
        let!(:recipes_response) do
          get api_v1_recipes_path, params: { country: 'دولة الكويت', api_key: '12345' }
          JSON.parse(response.body, symbolize_names: true)
        end

        it { expect(response).to have_http_status :bad_request }

        it 'returns an error stating a country is required' do
          expect(recipes_response).to have_key(:errors)
          expect(recipes_response[:errors]).to be_an Array
          expect(recipes_response[:errors][0][:status]).to eq 'Bad Request'
          expect(recipes_response[:errors][0][:message]).to eq 'Country invalid for: دولة الكويت'
          expect(recipes_response[:errors][0][:code]).to eq 400
        end
      end

      describe 'and then I enter a incorrect country name and then it' do
        let!(:recipes_response) do
          get api_v1_recipes_path, params: { country: 'Ohio', api_key: '12345' }
          JSON.parse(response.body, symbolize_names: true)
        end

        it { expect(response).to have_http_status :bad_request }

        it 'returns an error stating a country is required' do
          expect(recipes_response).to have_key(:errors)
          expect(recipes_response[:errors]).to be_an Array
          expect(recipes_response[:errors][0][:status]).to eq 'Bad Request'
          expect(recipes_response[:errors][0][:message]).to eq 'Country invalid for: Ohio'
          expect(recipes_response[:errors][0][:code]).to eq 400
        end
      end
    end
  end
end
