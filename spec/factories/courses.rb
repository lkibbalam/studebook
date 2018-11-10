# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    author
    team

    factory :course_with_lessons do
      transient do
        count { 3 } # TODO: Check how it works
      end
      after(:create) do |course, options|
        create_list(:lesson, options.count, course: course)
      end
    end
  end
end
