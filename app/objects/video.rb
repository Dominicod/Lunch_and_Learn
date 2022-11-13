# frozen_string_literal: true

class Video # rubocop:todo Style/Documentation
  attr_reader :title,
              :youtube_video_id

  def initialize(response)
    @title = response[:snippet][:title]
    @youtube_video_id = response[:id][:videoId]
  end
end
