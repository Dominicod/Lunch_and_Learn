# frozen_string_literal: true

class User < ApplicationRecord
  validates :name,
            :password_digest,
            presence: true
  validates :email,
            :api_key,
            presence: true,
            uniqueness: true
  has_many :favorites, dependent: :destroy

  has_secure_password
end
