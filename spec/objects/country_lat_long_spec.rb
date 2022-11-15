# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CountryLatLong, :vcr, type: :object do
  let(:country_object) do
    response = CountryService.country_lat_long('france')
    described_class.new(response)
  end

  describe 'Instantiation' do
    it 'returns long' do
      expect(country_object.long).to be_an Float
      expect(country_object.long).to eq 2.33
    end

    it 'returns lat' do
      expect(country_object.lat).to be_an Float
      expect(country_object.lat).to eq 48.87
    end
  end
end
