# frozen_string_literal: true

class VideoFacade
  def self.create_video(query)
    response = VideoService.country_video(query)
    return [] if response[:pageInfo][:totalResults].zero?

    Video.new(response[:items][0])
  end
end
