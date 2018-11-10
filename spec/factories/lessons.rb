# frozen_string_literal: true

FactoryBot.define do
  factory :lesson do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    material { Faker::Lorem.paragraph }
    course

    factory :lesson_with_3_tasks do
      after(:create) do |lesson|
        create_list(:task, 3, lesson: lesson)
      end
    end
  end
end
