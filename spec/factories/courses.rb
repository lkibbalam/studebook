# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    author
    team

    trait(:published) { status { :published } }
    trait(:unpublished) { status { :unpublished } }

    factory :course_with_lessons_with_tasks do
      transient do
        lessons_count { 3 } # TODO: Check how it works
        tasks_count { 3 }
      end
      after(:create) do |course, options|
        create_list(:lesson_with_tasks, options.lessons_count, tasks_count: options.tasks_count, course: course)
      end
    end
  end
end
