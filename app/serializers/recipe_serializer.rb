# frozen_string_literal: true

class RecipeSerializer
  include JSONAPI::Serializer
  attributes :title, :url, :country, :image
end
