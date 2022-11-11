# frozen_string_literal: true

class Country
  attr_reader :name

  def initialize(response)
    @name = response.dig(:data, :name, :official)
  end
end
