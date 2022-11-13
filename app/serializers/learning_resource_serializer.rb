# frozen_string_literal: true

class LearningResourceSerializer
  include JSONAPI::Serializer
  attributes :country, :video, :images
end
