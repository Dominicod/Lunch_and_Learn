class Recipe
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
