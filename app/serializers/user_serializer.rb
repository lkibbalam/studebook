# frozen_string_literal: true

class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :mentor_id, :team_id, :first_name, :last_name, :role, :phone, :github_url, :email

  attribute :avatar_url do |object|
    Rails.application.routes.url_helpers.rails_blob_url(object.avatar) if object.avatar.attached?
  end
end
