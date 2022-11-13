# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VideoFacade, :vcr, type: :facade do
  describe '.create_video' do
    it 'creates a video object' do
      expect(described_class.create_video('Laos')).to be_an_instance_of Video
    end

    it 'returns empty array if search results are zero' do
      expect(described_class.create_video('youarenotfindingavideo')).to eq []
    end
  end
end
