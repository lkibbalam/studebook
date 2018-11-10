# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    lesson
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
  end
end
