# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    user
    tasks_user
    status { :unseen }
  end
end
