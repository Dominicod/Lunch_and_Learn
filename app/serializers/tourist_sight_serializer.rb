# frozen_string_literal: true

class TouristSightSerializer
  include JSONAPI::Serializer
  attributes :name, :address, :place_id
end
