# frozen_string_literal: true

class CountryFacade
  def self.random_country
    response = CountryService.country_list
    Country.new(response.sample)
  end
end
