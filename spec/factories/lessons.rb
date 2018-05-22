# frozen_string_literal: true

FactoryBot.define do
  factory :lesson do
    description 'MyText'
    material 'MyText'
    task 'MyText'
    course
  end
end
