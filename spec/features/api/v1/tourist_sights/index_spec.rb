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
  end
end
