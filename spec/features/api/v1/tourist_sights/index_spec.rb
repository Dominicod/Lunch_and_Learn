# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tourist Sights | Index', :vcr, type: :request do
  describe 'As a User, when I visit /tourist_sights and then enter the query param of a country' do
    context('Happy Path') do
      describe 'I enter ?country=france and then it' do
        let!(:tourist_response) do
          get api_v1_tourist_sights_path, params: { country: 'france', api_key: create(:user).api_key }
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

    context('Sad Path') do
      describe "I enter ?country='' and then it" do
        let!(:tourist_response) do
          get api_v1_tourist_sights_path, params: { country: '', api_key: create(:user).api_key }
          JSON.parse(response.body, symbolize_names: true)
        end

        it { expect(response).to have_http_status :ok }

        it 'returns empty array if no string passed to param' do
          expect(tourist_response).to have_key(:data)
          expect(tourist_response[:data]).to eq []
        end
      end

      describe 'I do not enter a query param for country and then it' do
        let!(:tourist_response) do
          mocked_country = Country.new({ name: { common: 'Laos' } })
          allow(CountryFacade).to receive(:random_country).and_return(mocked_country)
          get api_v1_tourist_sights_path, params: { api_key: create(:user).api_key }
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
          get api_v1_tourist_sights_path, params: { country: 'دولة الكويت', api_key: create(:user).api_key }
          JSON.parse(response.body, symbolize_names: true)
        end

        it { expect(response).to have_http_status :bad_request }

        it 'returns an error stating a country is required' do
          expect(tourist_response).to have_key(:errors)
          expect(tourist_response[:errors]).to be_an Array
          expect(tourist_response[:errors][0][:status]).to eq 'Bad Request'
          expect(tourist_response[:errors][0][:message]).to eq 'Country invalid for: دولة الكويت'
          expect(tourist_response[:errors][0][:code]).to eq 400
        end
      end

      describe 'and then I enter a incorrect country name and then it' do
        let!(:tourist_response) do
          get api_v1_tourist_sights_path, params: { country: 'Ohio', api_key: create(:user).api_key }
          JSON.parse(response.body, symbolize_names: true)
        end

        it { expect(response).to have_http_status :bad_request }

        it 'returns an error stating a country is required' do
          expect(tourist_response).to have_key(:errors)
          expect(tourist_response[:errors]).to be_an Array
          expect(tourist_response[:errors][0][:status]).to eq 'Bad Request'
          expect(tourist_response[:errors][0][:message]).to eq 'Country invalid for: Ohio'
          expect(tourist_response[:errors][0][:code]).to eq 400
        end
      end

      describe 'and if I do not provide an API_KEY I am given a 401 auth error' do
        let!(:tourist_response) do
          get api_v1_tourist_sights_path, params: { country: 'Laos' }
          JSON.parse(response.body, symbolize_names: true)
        end

        it { expect(response).to have_http_status :unauthorized }

        it 'has correct attributes' do
          expect(tourist_response[:errors]).to be_an Array
          expect(tourist_response[:errors][0][:status]).to eq 'Unauthorized'
          expect(tourist_response[:errors][0][:message]).to eq 'API Key Omitted or Invalid'
          expect(tourist_response[:errors][0][:code]).to eq 401
        end
      end
    end
  end
end
