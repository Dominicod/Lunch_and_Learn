# frozen_string_literal: true

class TourismSightFacade
  def self.create_sights(query)
    return [] if query.empty?

    obj = CountryFacade.country_lat_long(query)
    sights_response = TouristSightService.sights(obj.long, obj.lat)

    sights_response[:features].map { |sight| TouristSight.new(sight) }
  end
end
