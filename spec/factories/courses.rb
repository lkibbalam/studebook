# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    description 'MyText'
    title 'MyString'
    author
    team
  end
end
