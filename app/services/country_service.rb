# frozen_string_literal: true

class CountryService
  def self.country_list
    parse(conn.get('/v3.1/all?fields=name'))
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://restcountries.com')
  end
end
