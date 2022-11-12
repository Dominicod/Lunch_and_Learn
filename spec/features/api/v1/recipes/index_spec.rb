# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recipes | Index', :vcr, type: :request do
  describe 'As a User, when I visit /recipes' do
    describe 'and then enter the query param of ?country=thailand (Happy Path)' do
      let!(:recipes_response) do
        get api_v1_recipes_path, params: { country: 'thailand' }
        JSON.parse(response.body, symbolize_names: true)
      end

      it { expect(recipes_response[:data]).to all(have_key(:id)) }
      it { expect(recipes_response[:data]).to all(have_key(:attributes)) }

      it { expect(recipes_response[:data][0][:attributes]).to have_key(:title) }
      it { expect(recipes_response[:data][0][:attributes]).to have_key(:url) }
      it { expect(recipes_response[:data][0][:attributes]).to have_key(:country) }
      it { expect(recipes_response[:data][0][:attributes]).to have_key(:image) }

      it { expect(recipes_response[:data][0][:attributes]).not_to have_key(:images) }
      it { expect(recipes_response[:data][0][:attributes]).not_to have_key(:health_labels) }
      it { expect(recipes_response[:data][0][:attributes]).not_to have_key(:cautions) }
    end

    describe 'and then enter the query param of ?country=notarealcountryatall (Sad Path)' do
      let!(:recipes_response) do
        get api_v1_recipes_path, params: { country: 'notarealcountryatall' }
        JSON.parse(response.body, symbolize_names: true)
      end

      it { expect(recipes_response).to have_key(:data) }
      it { expect(recipes_response[:data]).to eq [] }
    end
  end
end
