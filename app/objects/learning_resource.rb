# frozen_string_literal: true

class Recipe # rubocop:todo Style/Documentation
  attr_reader :id,
              :country,
              :video,
              :images

  def initialize(images, video, query)
    @id = nil
    @country = query
    @video = video
    @images = []
  end
end
