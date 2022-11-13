# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LearningResource, :vcr, type: :object do
  let(:query) { 'Laos' }
  let(:learning_object) { LearningResourceFacade.create_learning_resource('Laos') }

  describe 'Instantiation' do
    it 'returns id' do
      expect(learning_object.id).to eq nil
    end

    it 'returns country' do
      expect(learning_object.country).to eq query
    end

    it 'returns video' do
      expect(learning_object.video).to be_an_instance_of Video
    end

    it 'returns images' do
      expect(learning_object.images).to all(be_an_instance_of(Image))
    end
  end
end
