# frozen_string_literal: true

class LessonSerializer < ActiveModel::Serializer
  attributes %i[poster video title description course_id material tasks]

  def poster
    Rails.application.routes.url_helpers.rails_blob_url(object.poster) if object.poster.attached?
  end

  def video
    Rails.application.routes.url_helpers.rails_blob_url(object.video) if object.video.attached?
  end

  def tasks
    object.tasks
  end
end
