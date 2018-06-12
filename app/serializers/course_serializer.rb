# frozen_string_literal: true

class CourseSerializer < ActiveModel::Serializer
  attributes %i[id title description poster team_id author_id created_at updated_at lessons]

  def poster
    Rails.application.routes.url_helpers.rails_blob_url(object.poster) if object.poster.attached?
  end

  def lessons
    object.lessons
  end
end
