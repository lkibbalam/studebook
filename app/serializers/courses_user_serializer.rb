# frozen_string_literal: true

class CoursesUserSerializer < ActiveModel::Serializer
  attributes %i[current_lesson status created_at updated_at progress course poster lessons student description title]

  def course
    object.course
  end

  def description
    course.description
  end

  def title
    course.title
  end

  def lessons
    course.lessons.order('created_at asc')
  end

  def student
    object.student
  end

  def current_lesson
    current_user.lessons_users.where(lesson_id: lessons.ids, status: :unlocked).first
  end

  def poster
    Rails.application.routes.url_helpers.rails_blob_url(course.poster) if course.poster.attached?
  end
end
