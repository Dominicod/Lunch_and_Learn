# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Image, :vcr, type: :object do
  let(:query) { 'Laos' }
  let(:image_object) do
    response = ImagesService.country_images(query)
    described_class.new(response[:results][0])
  end

  describe 'Instantiation' do
    it 'returns alt tag' do
      expect(image_object.alt_tag).to be_an String
    end

    it 'returns url' do
      expect(image_object.url).to be_an String
    end
  end
end
