# frozen_string_literal: true

class CountryService
  include ServiceHelperModule
  def self.country_list
    parse(conn.get('/v3.1/all?fields=name'))
  end

  def self.country_lat_long(country)
    parse(conn.get("/v3.1/name/#{ServiceHelperModule.encode_uri(country)}"))
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://restcountries.com')
  end
end
