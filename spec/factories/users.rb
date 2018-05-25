# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user, aliases: %i[author mentor student] do
    first_name 'MyFirst_name'
    last_name 'MyLast_name'
    email
    password '12345678'
    password_confirmation '12345678'
    phone 9999
    role 'student'
    team
  end
end
