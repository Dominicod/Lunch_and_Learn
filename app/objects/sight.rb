# frozen_string_literal: true

class Sight # rubocop:todo Style/Documentation
  attr_reader :name,
              :address,
              :place_id

  def initialize(response)
    @name = response[:properties][:name]
    @address = response[:properties][:formatted]
    @place_id = response[:properties][:place_id]
  end
end
