# frozen_string_literal: true

FactoryBot.define do
  factory :favorite do
    country { Faker::Games::Minecraft.biome }
    recipe_link { Faker::Internet.url }
    recipe_title { Faker::Games::Minecraft.achievement }

    association :user
  end
end
