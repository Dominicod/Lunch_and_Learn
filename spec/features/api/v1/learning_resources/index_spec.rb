# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Learning Resources | Index', :vcr, type: :request do
  describe 'As a User, when I visit /learning_resources and then enter the query param of a country' do
    context('Happy Path') do
      describe 'I enter ?country=laos and then it' do
        let!(:lr_response) do
          get api_v1_learning_resources_path, params: { country: 'laos', api_key: create(:user).api_key }
          JSON.parse(response.body, symbolize_names: true)
        end

        it { expect(response).to have_http_status :ok }

        it 'has correct attributes' do
          expect(lr_response[:data]).to have_key(:id)
          expect(lr_response[:data]).to have_key(:attributes)
          expect(lr_response[:data][:attributes]).to have_key(:country)
          expect(lr_response[:data][:attributes]).to have_key(:video)
          expect(lr_response[:data][:attributes]).to have_key(:images)
          expect(lr_response[:data][:attributes][:images]).to be_an Array
          expect(lr_response[:data][:attributes][:images][0][:alt_tag]).to be_an String
          expect(lr_response[:data][:attributes][:images][0][:url]).to be_an String
          expect(lr_response[:data][:attributes][:video]).to be_an Hash
          expect(lr_response[:data][:attributes][:video][:title]).to be_an String
          expect(lr_response[:data][:attributes][:video][:youtube_video_id]).to be_an String

          expect(lr_response[:data][:attributes]).not_to have_key(:blur_hash)
          expect(lr_response[:data][:attributes]).not_to have_key(:likes)
        end
      end
    end

    context('Sad Path') do
      describe 'I enter ?country=thisisnotacountry and then it' do
        let!(:lr_response) do
          get api_v1_learning_resources_path, params: { country: 'thisisnotacountry', api_key: create(:user).api_key }
          JSON.parse(response.body, symbolize_names: true)
        end

        it { expect(response).to have_http_status :ok }

        it 'returns empty array in correct fields if country has no videos and/or images' do
          expect(lr_response[:data]).to have_key(:id)
          expect(lr_response[:data]).to have_key(:attributes)
          expect(lr_response[:data][:attributes]).to have_key(:country)
          expect(lr_response[:data][:attributes]).to have_key(:video)
          expect(lr_response[:data][:attributes]).to have_key(:images)
          expect(lr_response[:data][:attributes][:images]).to eq []
          expect(lr_response[:data][:attributes][:video]).to eq []
        end
      end
    end

    context('Edge Case') do
      describe 'and then I insert a non-ASCII supported list of characters into params (Edge Case)' do
        let!(:lr_response) do
          get api_v1_learning_resources_path, params: { country: 'دولة الكويت', api_key: create(:user).api_key }
          JSON.parse(response.body, symbolize_names: true)
        end

        it { expect(response).to have_http_status :ok }

        it 'has correct attributes' do
          expect(lr_response[:data]).to have_key(:id)
          expect(lr_response[:data]).to have_key(:attributes)
          expect(lr_response[:data][:attributes]).to have_key(:country)
          expect(lr_response[:data][:attributes]).to have_key(:video)
          expect(lr_response[:data][:attributes]).to have_key(:images)
        end
      end

      describe 'and if I do not provide an API_KEY I am given a 401 auth error' do
        let!(:lr_response) do
          get api_v1_learning_resources_path, params: { country: 'Laos' }
          JSON.parse(response.body, symbolize_names: true)
        end

        it { expect(response).to have_http_status :unauthorized }

        it 'has correct attributes' do
          expect(lr_response[:errors]).to be_an Array
          expect(lr_response[:errors][0][:status]).to eq 'Unauthorized'
          expect(lr_response[:errors][0][:message]).to eq 'API Key Omitted or Invalid'
          expect(lr_response[:errors][0][:code]).to eq 401
        end
      end
    end
  end
end
