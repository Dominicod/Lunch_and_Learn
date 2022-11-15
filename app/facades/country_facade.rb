# frozen_string_literal: true

class CountryFacade
  def self.random_country
    response = CountryService.country_list
    Country.new(response.sample)
  end

  def self.country_lat_long(query)
    CountryLatLong.new(CountryService.country_lat_long(query))
  end

  def self.country?(query)
    CountryService.country_lat_long(query)[0]
  end
end
