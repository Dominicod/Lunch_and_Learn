# frozen_string_literal: true

class Image # rubocop:todo Style/Documentation
  attr_reader :alt_tag,
              :url

  def initialize(response)
    @alt_tag = response[:alt_description]
    @url = response[:urls][:raw]
  end
end
