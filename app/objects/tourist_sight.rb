# frozen_string_literal: true

class TouristSight
  attr_reader :name,
              :address,
              :place_id,
              :id

  def initialize(response)
    @id = nil
    @name = response[:properties][:name]
    @address = response[:properties][:formatted]
    @place_id = response[:properties][:place_id]
  end
end
