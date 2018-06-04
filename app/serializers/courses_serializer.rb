# frozen_string_literal: true

class CoursesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :team_id, :author_id, :description, :title, :poster_url

  attribute :poster_url do |object|
    Rails.application.routes.url_helpers.rails_blob_url(object.poster) if object.poster.attached?
  end
end
