# frozen_string_literal: true

class VideoService
  include ServiceHelperModule
  def self.country_video(country)
    parse(conn.get("?q=#{ServiceHelperModule.encode_uri(country)}"))
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(
      url: 'https://www.googleapis.com/youtube/v3/search',
      params: {
        key: ENV['GOOGLE_API_KEY'],
        channelId: 'UCluQ5yInbeAkkeCndNnUhpw',
        part: 'snippet',
        maxResults: 1
      }
    )
  end
end
