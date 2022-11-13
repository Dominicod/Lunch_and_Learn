# frozen_string_literal: true

class Recipe # rubocop:todo Style/Documentation
  attr_reader :id,
              :country,
              :video,
              :images

  def initialize(images, video, query)
    @id = nil
    @country = query
    @video = {
      title: video[:snippet][:title],
      youtube_video_id: video[:id][:videoId]
    }
    @images = []
  end
end
