# frozen_string_literal: true

class RecipeFacade # rubocop:todo Style/Documentation
  def self.create_recipes(query)
    response = RecipeService.recipes(query)
    response[:hits].map { |recipe| Recipe.new(recipe[:recipe], query) }
  end
end
