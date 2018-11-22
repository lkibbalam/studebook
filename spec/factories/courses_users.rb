# frozen_string_literal: true

FactoryBot.define do
  factory :courses_user do
    student
    course
    mark { 0 }
    status { 0 }
    progress { 0 }
  end
end
