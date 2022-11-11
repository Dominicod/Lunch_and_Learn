# frozen_string_literal: true

class RecipeService
  def self.recipes(country)
    parse(conn.get('api/recipes/v2', { q: country }))
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://api.edamam.com/', {
                  app_id: ENV['APP_ID'],
                  app_key: ENV['APP_KEY']
                })
  end
end
