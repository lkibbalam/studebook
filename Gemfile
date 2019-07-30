# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby "2.6.3"
gem "rails", "~> 5.2.3"

gem "active_model_serializers", "~> 0.10.7"
gem "ancestry"
gem "aws-sdk-s3", require: false
gem "bootsnap"
gem "friendly_id"
gem "graphql"
gem "graphql-batch"
gem "graphql-guard"
gem "jwt"
gem "kaminari"
gem "knock"
gem "oj"
gem "oj_mimic_json"
gem "pg"
gem "puma"
gem "pundit"
gem "rack-cors", require: "rack/cors"
gem "responders"
gem "acts_as_list"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "rubocop"
  gem "rubocop-rspec"
  gem "pry"
  gem "pry-rails"
end

group :development do
  gem "graphiql-rails"
  gem "letter_opener"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem "faker"
  gem "json_spec", "~> 1.1", ">= 1.1.5"
  gem "pundit-matchers"
  gem "rails-controller-testing"
  gem "rspec-rails"
  gem "shoulda-matchers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
