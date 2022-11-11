# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeService, :vcr, type: :service do
  let(:response) { described_class.recipes('United States') }

  describe '.recipes' do
    it 'returns hits as an array' do
      expect(response[:hits]).to be_an Array
    end

    it 'returns recipe for given country' do
      expect(response[:hits][0][:recipe]).to be_an Hash
    end

    it 'has url as a string' do
      expect(response[:hits][0][:recipe][:url]).to be_an String
    end

    it 'has label as a string' do
      expect(response[:hits][0][:recipe][:label]).to be_an String
    end

    it 'has image as a string' do
      expect(response[:hits][0][:recipe][:image]).to be_an String
    end
  end
end
