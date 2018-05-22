# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    lesson
    title 'My title'
    description 'My desc'
  end
end
