# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImageFacade, :vcr, type: :facade do
  describe '.create_images' do
    it 'creates an array of image objects' do
      expect(described_class.create_images('Laos')).to be_an Array
    end

    it 'objects are Image objects' do
      expect(described_class.create_images('Laos')).to all(be_an_instance_of(Image))
    end

    it 'returns empty array if search results are zero' do
      expect(described_class.create_images('Absolutelynotaimage')).to eq []
    end
  end
end
