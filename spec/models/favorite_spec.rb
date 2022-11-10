# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'Relationships' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:recipe_title) }
    it { is_expected.to validate_presence_of(:recipe_link) }
    it { is_expected.to validate_presence_of(:country) }
  end
end
