# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImagesService, :vcr, type: :service do
  let(:response) { described_class.country_images('Angola') }

  describe '.country_images' do
    it 'returns results as an array' do
      expect(response[:results]).to be_an Array
    end

    it 'results array count is not greater than 10' do
      expect(response[:results].count).to be <= 10
    end

    it 'returns each image as a hash' do
      expect(response[:results][0]).to be_an Hash
    end

    it 'returns alt_description as a string' do
      expect(response[:results][0][:alt_description]).to be_an String
    end

    it 'returns urls as a hash' do
      expect(response[:results][0][:urls]).to be_an Hash
    end

    it 'returns raw_url as a string' do
      expect(response[:results][0][:urls][:raw]).to be_an String
    end
  end
end
