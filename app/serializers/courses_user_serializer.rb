# frozen_string_literal: true

class CoursesUserSerializer < ActiveModel::Serializer
  attributes %i[status created_at updated_at progress course poster]

  def course
    object.course
  end

  def poster
    Rails.application.routes.url_helpers.rails_blob_url(course.poster) if course.poster.attached?
  end
end
