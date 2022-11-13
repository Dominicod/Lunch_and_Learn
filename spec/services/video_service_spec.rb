# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VideoService, :vcr, type: :service do
  let(:response) { described_class.country_video('Angola') }

  describe '.country_video' do
    it 'returns items as an array' do
      expect(response[:items]).to be_an Array
    end

    it 'returns snippet as a hash' do
      expect(response[:items][0][:snippet]).to be_an Hash
    end

    it 'returns title as a string' do
      expect(response[:items][0][:snippet][:title]).to be_an String
    end

    it 'returns id as a hash' do
      expect(response[:items][0][:id]).to be_an Hash
    end

    it 'returns video id as a string' do
      expect(response[:items][0][:id][:videoId]).to be_an String
    end
  end
end
