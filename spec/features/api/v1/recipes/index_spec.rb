# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recipes | Index', :vcr, type: :request do
  describe 'As a User, when I visit /recipes' do
    describe 'and then enter the query param of ?country=thailand (Happy Path)' do
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

    describe 'and then enter the query param of ?country=notarealcountryatall (Sad Path)' do
      let!(:recipes_response) do
        get api_v1_recipes_path, params: { country: 'notarealcountryatall' }
        JSON.parse(response.body, symbolize_names: true)
      end

      it { expect(response).to have_http_status :ok }

      it 'has correct attributes' do
        expect(recipes_response).to have_key(:data)
        expect(recipes_response[:data]).to eq []
      end

      it 'returns empty array if no string passed to param' do
        get api_v1_recipes_path, params: { country: '' }
        expect(recipes_response[:data]).to eq []
      end
    end

    describe 'and then I do not enter a query param and a random country is chosen for me (Sad Path)' do
      let!(:recipes_response) do
        mocked_country = Country.new({ name: { common: 'United States' } })
        allow(CountryFacade).to receive(:random_country).and_return(mocked_country)
        get api_v1_recipes_path
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
  end
end
