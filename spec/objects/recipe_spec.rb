# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe, :vcr, type: :object do
  let(:query) { 'United States' }
  let(:recipe_object) do
    response = RecipeService.recipes(query)
    described_class.new(response[:hits][0], query)
  end

  describe 'Instantiation' do
    it 'returns title' do
      expect(recipe_object.title).to be_an String
    end

    it 'returns url' do
      expect(recipe_object.url).to be_an String
    end

    it 'returns country' do
      expect(recipe_object.country).to eq query
    end

    it 'returns image' do
      expect(recipe_object.image).to be_an String
    end
  end
end
