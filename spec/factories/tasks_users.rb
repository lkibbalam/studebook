# frozen_string_literal: true

FactoryBot.define do
  factory :tasks_user do
    github_url { Faker::Internet.url('github.com') }
    mark { 0 }
    status { 0 }
    task
    user
  end
end
