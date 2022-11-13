# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video, :vcr, type: :object do
  let(:query) { 'Laos' }
  let(:recipe_object) do
    response = VideoService.country_video(query)
    described_class.new(response[:items][0])
  end

  describe 'Instantiation' do
    it 'returns title' do
      expect(recipe_object.title).to be_an String
    end

    it 'returns videoId' do
      expect(recipe_object.youtube_video_id).to be_an String
    end
  end
end
