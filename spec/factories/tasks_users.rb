# frozen_string_literal: true

FactoryBot.define do
  factory :tasks_user do
    github_url 'my url'
    mark 0
    status 0
  end
end
