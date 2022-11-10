# frozen_string_literal: true

class Favorite < ApplicationRecord
  validates :recipe_title,
            :recipe_link,
            :country,
            presence: true
  belongs_to :user
end
