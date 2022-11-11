# frozen_string_literal: true

class Recipe # rubocop:todo Style/Documentation
  attr_reader :title,
              :url,
              :country,
              :image

  def initialize(response, query)
    @title = response.dig(:recipe, :label)
    @url = response.dig(:recipe, :url)
    @country = query
    @image = response.dig(:recipe, :image)
  end
end
