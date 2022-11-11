# frozen_string_literal: true

class Recipe # rubocop:todo Style/Documentation
  attr_reader :id,
              :title,
              :url,
              :country,
              :image

  def initialize(response, query)
    @id = nil
    @title = response[:label]
    @url = response[:url]
    @country = query[:country]
    @image = response[:image]
  end
end
