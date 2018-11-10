# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: %i[student mentor author] do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    nickname { Faker::Internet.username }
    password { Faker::Internet.password(8) }
    phone { Faker::PhoneNumber.phone_number }
    team

    trait(:admin) { role { :admin } }
    trait(:leader) { role { :leader } }
    trait(:moder) { role { :moder } }
    trait(:staff) { role { :staff } }
    trait(:student) { role { :student } }
    trait(:inactive) { status { :inactive } }
  end
end
