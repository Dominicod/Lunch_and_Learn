# frozen_string_literal: true

class CountryService # rubocop:todo Style/Documentation
  def self.country_list
    parse(conn.get('/v3.1/all?fields=name'))
  end

  def self.valid_country?(country)
    parse(conn.get("/v3.1/name/#{encode_uri(country)}"))
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://restcountries.com')
  end
end
