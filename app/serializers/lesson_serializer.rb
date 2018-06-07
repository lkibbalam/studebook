# frozen_string_literal: true

class LessonSerializer < ActiveModel::Serializer
  attributes %i[poster_url video_url title description course_id material]

  def poster_url
    Rails.application.routes.url_helpers.rails_blob_url(object.poster) if object.poster.attached?
  end

  def video_url
    Rails.application.routes.url_helpers.rails_blob_url(object.video) if object.video.attached?
  end
end
