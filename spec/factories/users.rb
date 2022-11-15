# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Internet.username }
    email { Faker::Internet.safe_email }
    password_digest { Faker::Internet.password }
    api_key { Faker::Number.number(digits: 12).to_s }
  end
end
