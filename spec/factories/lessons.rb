# frozen_string_literal: true

FactoryBot.define do
  factory :lesson do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    material { Faker::Lorem.paragraph }
    course

    factory :lesson_with_tasks do
      transient do
        tasks_count { 3 }
      end
      after(:create) do |lesson, options|
        create_list(:task, options.tasks_count, lesson: lesson)
      end
    end
  end
end
