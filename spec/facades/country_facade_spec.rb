# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CountryFacade, :vcr, type: :facade do
  describe '.random_country' do
    it 'creates a object with a random country' do
      expect(described_class.random_country).to be_an_instance_of Country
    end
  end
end
