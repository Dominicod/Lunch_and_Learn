# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Relationships' do
    it { is_expected.to have_many(:favorites).dependent(:destroy) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:password_digest) }
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:api_key) }
    it { is_expected.to validate_uniqueness_of(:api_key) }
  end
end
