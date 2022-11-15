# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CountryService, :vcr, type: :service do
  describe '.country_list' do
    let(:response) { described_class.country_list }

    it 'returns as an array' do
      expect(response).to be_an Array
    end

    it 'returns name as hash' do
      expect(response[0][:name]).to be_an Hash
    end

    it 'returns official name as string' do
      expect(response[0][:name][:official]).to be_an String
    end
  end

  describe '.country_lat_long' do
    let(:response) { described_class.country_lat_long('france') }

    it 'returns as an array' do
      expect(response).to be_an Array
    end

    it 'returns capital info as a hash' do
      expect(response[0][:capitalInfo]).to be_an Hash
    end

    it 'returns latlng as an array' do
      expect(response[0][:capitalInfo][:latlng]).to be_an Array
    end

    it 'returns lat as an float' do
      expect(response[0][:capitalInfo][:latlng][0]).to be_an Float
    end

    it 'returns long as an float' do
      expect(response[0][:capitalInfo][:latlng][1]).to be_an Float
    end
  end
end
