# frozen_string_literal: true

class FavoriteSerializer
  include JSONAPI::Serializer
  attributes :recipe_title, :country, :recipe_link, :created_at
end
