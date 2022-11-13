# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LearningResourceFacade, :vcr, type: :facade do
  describe '.create_learning_resource' do
    it 'create a learning resource obj' do
      expect(described_class.create_learning_resource('Laos')).to be_an_instance_of LearningResource
    end
  end
end
