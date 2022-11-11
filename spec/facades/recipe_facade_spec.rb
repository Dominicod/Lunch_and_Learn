# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeFacade, :vcr, type: :facade do
  describe '.create_recipes' do
    it 'creates an array of recipe objects' do
      expect(described_class.create_recipes('United States')).to be_an Array
    end

    it 'objects are Recipe objects' do
      expect(described_class.create_recipes('United States')).to all(be_an_instance_of(Recipe))
    end
  end
end
