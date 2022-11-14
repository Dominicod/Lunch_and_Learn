# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tourist Sights | Index', :vcr, type: :request do # rubocop:todo Metrics/BlockLength
  # rubocop:todo Metrics/BlockLength
  describe 'As a User, when I visit /tourist_sights and then enter the query param of a country' do
    context('Happy Path') do
      describe 'I enter ?country=france and then it' do
        let!(:tourist_response) do
          get api_v1_tourist_sights_path, params: { country: 'france' }
          JSON.parse(response.body, symbolize_names: true)
        end

        it { expect(response).to have_http_status :ok }

        it 'has correct attributes' do
          expect(tourist_response[:data]).to all(have_key(:id))
          expect(tourist_response[:data]).to all(have_key(:attributes))
          expect(tourist_response[:data][0][:attributes]).to have_key(:name)
          expect(tourist_response[:data][0][:attributes]).to have_key(:address)
          expect(tourist_response[:data][0][:attributes]).to have_key(:place_id)
          expect(tourist_response[:data][0][:attributes]).not_to have_key(:housenumber)
          expect(tourist_response[:data][0][:attributes]).not_to have_key(:district)
          expect(tourist_response[:data][0][:attributes]).not_to have_key(:city)
        end
      end
    end

    context('Sad Path') do # rubocop:todo Metrics/BlockLength
      describe 'I enter ?country=Djibouti and then it' do
        let!(:tourist_response) do
          get api_v1_tourist_sights_path, params: { country: 'france' }
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
        let!(:tourist_response) do
          mocked_country = Country.new({ name: { common: 'United States' } })
          allow(CountryFacade).to receive(:random_country).and_return(mocked_country)
          get api_v1_tourist_sights_path
          JSON.parse(response.body, symbolize_names: true)
        end

        it { expect(response).to have_http_status :ok }

        it 'chooses a random country and has correct attributes' do
          expect(tourist_response[:data]).to all(have_key(:id))
          expect(tourist_response[:data]).to all(have_key(:attributes))
          expect(tourist_response[:data][0][:attributes]).to have_key(:name)
          expect(tourist_response[:data][0][:attributes]).to have_key(:address)
          expect(tourist_response[:data][0][:attributes]).to have_key(:place_id)
          expect(tourist_response[:data][0][:attributes]).not_to have_key(:housenumber)
          expect(tourist_response[:data][0][:attributes]).not_to have_key(:district)
          expect(tourist_response[:data][0][:attributes]).not_to have_key(:city)
        end
      end
    end

    context('Edge Case') do
      describe 'and then I insert a non-ASCII supported list of characters into params (Edge Case)' do
        let!(:tourist_response) do
          get api_v1_tourist_sights_path, params: { country: 'دولة الكويت' }
          JSON.parse(response.body, symbolize_names: true)
        end

        it { expect(response).to have_http_status :ok }

        it 'has correct attributes' do
          expect(tourist_response).to have_key(:data)
          expect(tourist_response[:data]).to eq []
        end
      end

      describe 'and then I enter a incorrect country name and then it' do
        let!(:tourist_response) do
          get api_v1_tourist_sights_path, params: { country: 'Ohio' }
          JSON.parse(response.body, symbolize_names: true)
        end

        xit { expect(response).to have_http_status :not_found }

        xit 'it returns an array, stating the country does not exist'
      end
    end
  end
  # rubocop:enable Metrics/BlockLength
end
