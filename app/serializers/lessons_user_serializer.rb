# frozen_string_literal: true

class LessonsUserSerializer < ActiveModel::Serializer
  attributes %i[status lesson tasks course lessons student_id video poster]

  def lesson
    object.lesson
  end

  def tasks
    lesson.tasks
  end

  def course
    lesson.course
  end

  def lessons
    course.lessons
  end

  def video
    Rails.application.routes.url_helpers.rails_blob_url(lesson.video) if lesson.video.attached?
  end

  def poster
    Rails.application.routes.url_helpers.rails_blob_url(lesson.poster) if lesson.poster.attached?
  end
end
