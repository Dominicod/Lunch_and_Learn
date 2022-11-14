# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TouristSight, :vcr, type: :object do
  let(:sight_object) do
    response = TouristSightService.sights(-96.818733, 33.155373)
    described_class.new(response[:features][0])
  end

  describe 'Instantiation' do
    it 'returns name' do
      expect(sight_object.name).to be_an String
    end

    it 'returns address' do
      expect(sight_object.address).to be_an String
    end

    it 'returns places_id' do
      expect(sight_object.place_id).to be_an String
    end
  end
end
