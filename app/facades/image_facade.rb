# frozen_string_literal: true

class ImageFacade # rubocop:todo Style/Documentation
  def self.create_images(query)
    response = ImagesService.country_images(query)
    return [] if response[:total].zero?

    response[:results].map { |image| Image.new(image) }
  end
end
