# frozen_string_literal: true

FactoryBot.define do
  factory :lessons_user do
    lesson
    student
    status 1
    mark 1
  end
end
