# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Country, :vcr, type: :object do
  let(:country_object) do
    response = CountryService.country_list
    described_class.new(response.sample)
  end

  describe 'Instantiation' do
    it 'returns name' do
      expect(country_object.name).to be_an String
    end
  end
end
