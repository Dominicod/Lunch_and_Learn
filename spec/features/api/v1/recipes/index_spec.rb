# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recipes | Index', :vcr, type: :request do # rubocop:todo Metrics/BlockLength
  # rubocop:todo Metrics/BlockLength
  describe 'As a User, when I visit /recipes and then enter the query param of a country' do
    context('Happy Path') do
      describe 'I enter ?country=thailand and then it' do
        let!(:recipes_response) do
          get api_v1_recipes_path, params: { country: 'thailand' }
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

    context('Sad Path') do # rubocop:todo Metrics/BlockLength
      describe 'I enter ?country=Djibouti and then it' do
        let!(:recipes_response) do
          get api_v1_recipes_path, params: { country: 'Djibouti' }
          JSON.parse(response.body, symbolize_names: true)
        end

        it { expect(response).to have_http_status :ok }

        it 'returns empty array if country has no recipes' do
          expect(recipes_response).to have_key(:data)
          expect(recipes_response[:data]).to eq []
        end

        it 'returns empty array if no string passed to param' do
          get api_v1_recipes_path, params: { country: '' }

          expect(recipes_response).to have_key(:data)
          expect(recipes_response[:data]).to eq []
        end
      end

      describe 'I do not enter a query param for country and then it' do
        let!(:recipes_response) do
          mocked_country = Country.new({ name: { common: 'United States' } })
          allow(CountryFacade).to receive(:random_country).and_return(mocked_country)
          get api_v1_recipes_path
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
          get api_v1_recipes_path, params: { country: 'دولة الكويت' }
          JSON.parse(response.body, symbolize_names: true)
        end

        it { expect(response).to have_http_status :ok }

        it 'has correct attributes' do
          expect(recipes_response).to have_key(:data)
          expect(recipes_response[:data]).to eq []
        end
      end

      describe 'and then I enter a incorrect country name and then it' do
        let!(:recipes_response) do
          get api_v1_recipes_path, params: { country: 'Ohio' }
          JSON.parse(response.body, symbolize_names: true)
        end

        xit { expect(response).to have_http_status :not_found }

        xit 'it returns an array, stating the country does not exist'
      end
    end
  end
  # rubocop:enable Metrics/BlockLength
end
