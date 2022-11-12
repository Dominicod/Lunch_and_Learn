# frozen_string_literal: true

class RecipeService # rubocop:todo Style/Documentation
  include ServiceHelperModule
  def self.recipes(country)
    parse(conn.get("api/recipes/v2?q=#{ServiceHelperModule.encode_uri(country)}"))
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(
      url: 'https://api.edamam.com/',
      params: {
        app_id: ENV['ED_APP_ID'],
        app_key: ENV['ED_APP_KEY'],
        type: 'public'
      }
    )
  end
end
