# frozen_string_literal: true

class LessonSerializer
  include FastJsonapi::ObjectSerializer
  attributes :poster_url, :video_url, :title, :description, :course_id, :material

  attribute :poster_url do |object|
    Rails.application.routes.url_helpers.rails_blob_url(object.poster) if object.poster.attached?
  end

  attribute :video_url do |object|
    Rails.application.routes.url_helpers.rails_blob_url(object.video) if object.video.attached?
  end
end
