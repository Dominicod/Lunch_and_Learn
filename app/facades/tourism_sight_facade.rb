# frozen_string_literal: true

class TourismSightFacade # rubocop:todo Style/Documentation
  def self.create_sights(query)
    obj = CountryFacade.country_lat_long(query)
    return nil if obj.nil?

    sights_response = TouristSightService.sights(obj.long, obj.lat)

    sights_response[:features].map { |sight| TouristSight.new(sight) }
  end
end
