# frozen_string_literal: true

FactoryBot.define do
  factory :lesson do
    description 'MyText'
    material 'MyText'
    course

    trait :foo do
      description 'Trait'
    end
  end
end
