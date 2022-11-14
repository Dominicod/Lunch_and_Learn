# frozen_string_literal: true

class TouristSightService # rubocop:todo Style/Documentation
  include ServiceHelperModule
  def self.sight(long, lat)
    parse(conn.get("?categories=tourism.sights&filter=circle:#{long},#{lat},20000"))
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(
      url: 'https://api.geoapify.com/v2/places',
      params: {
        api_key: ENV['PLACES_KEY']
      }
    )
  end
end
