# frozen_string_literal: true

class LearningResource
  attr_reader :id,
              :country,
              :video,
              :images

  def initialize(images, video, query)
    @id = nil
    @country = query
    @video = video
    @images = images
  end
end
