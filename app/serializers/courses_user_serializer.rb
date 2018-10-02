# frozen_string_literal: true

class CoursesUserSerializer < ActiveModel::Serializer
  attributes %i[status created_at updated_at progress course poster lessons student]

  def course
    object.course
  end

  def lessons
    course.lessons
  end

  def student
    object.student
  end

  def poster
    Rails.application.routes.url_helpers.rails_blob_url(course.poster) if course.poster.attached?
  end
end
