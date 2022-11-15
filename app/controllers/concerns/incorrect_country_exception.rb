# frozen_string_literal: true

class IncorrectCountryException < StandardError
  attr_reader :data

  def initialize(data)
    super
    @data = data
  end
end
