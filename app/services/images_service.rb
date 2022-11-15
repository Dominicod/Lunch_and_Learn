# frozen_string_literal: true

class ImagesService
  include ServiceHelperModule
  def self.country_images(country)
    parse(conn.get("?query=#{ServiceHelperModule.encode_uri(country)}"))
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(
      url: 'https://api.unsplash.com/search/photos/',
      params: {
        client_id: ENV['UNSPLASH_CLIENT']
      }
    )
  end
end
