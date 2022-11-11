# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CountryService, :vcr, type: :service do
  let(:response) { described_class.country_list }

  describe '.country_list' do
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
end
