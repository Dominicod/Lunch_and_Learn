# frozen_string_literal: true

class Country # rubocop:todo Style/Documentation
  attr_reader :name

  def initialize(response)
    @name = response.dig(:name, :common)
  end
end
