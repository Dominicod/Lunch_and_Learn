# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TouristSightService, :vcr, type: :service do
  let(:response) { described_class.sights(-96.818733, 33.155373) }

  describe '.sights' do
    it 'returns features as an array' do
      expect(response[:features]).to be_an Array
    end

    it 'returns properties as a hash' do
      expect(response[:features][0][:properties]).to be_an Hash
    end

    it 'returns name as a string' do
      expect(response[:features][0][:properties][:name]).to be_an String
    end

    it 'returns address as a string' do
      expect(response[:features][0][:properties][:formatted]).to be_an String
    end

    it 'returns place_id as a string' do
      expect(response[:features][0][:properties][:place_id]).to be_an String
    end
  end
end
