# frozen_string_literal: true

FactoryBot.define do
  sequence(:email) { |n| "user#{n}@test.com" }

  factory :user, aliases: %i[student mentor author] do
    first_name { 'MyFirst_name' }
    last_name { 'MyLast_name' }
    email
    password { '12345678' }
    password_confirmation { '12345678' }
    phone { 9999 }
    role { 'student' }
    team

    trait(:admin) { role { :admin } }
    trait(:leader) { role { :leader } }
    trait(:moder) { role { :moder } }
    trait(:staff) { role { :staff } }
    trait(:student) { role { :student } }
    trait(:inactive) { status { :inactive } }
  end
end
