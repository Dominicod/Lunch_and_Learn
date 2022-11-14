# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TourismSightFacade, :vcr, type: :facade do
  describe '.create_sights' do
    it 'returns an array' do
      expect(described_class.create_sights('France')).to be_an Array
    end

    it 'returns an array of sight objects' do
      expect(described_class.create_sights('France')).to all(be_an_instance_of(TouristSight))
    end

    it 'returns empty array if search results are zero' do
      expect(described_class.create_sights('')).to eq []
    end
  end
end
