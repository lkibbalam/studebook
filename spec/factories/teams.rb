# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
  end
end
