# frozen_string_literal: true

FactoryBot.define do
  factory :video do
    title 'MyString'
    src 'MyString'
    lesson
    course
  end
end
