# frozen_string_literal: true

class CountryLatLong
  attr_reader :long,
              :lat

  def initialize(response)
    @long = response[0][:capitalInfo][:latlng][1]
    @lat = response[0][:capitalInfo][:latlng][0]
  end
end
