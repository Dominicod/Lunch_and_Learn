# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CountryFacade, :vcr, type: :facade do
  describe '.random_country' do
    it 'creates a object with a random country' do
      expect(described_class.random_country).to be_an_instance_of Country
    end
  end

  describe '.country_lat_long' do
    it "creates a object with a country's lat/long" do
      expect(described_class.country_lat_long('france')).to be_an_instance_of CountryLatLong
    end
  end
end
