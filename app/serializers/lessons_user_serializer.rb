# frozen_string_literal: true

class LessonsUserSerializer < ActiveModel::Serializer
  attributes %i[status lesson tasks course lessons student_id video poster tasks_user course_lessons_user]

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
    course.lessons.order('created_at asc')
  end

  def course_lessons_user
    current_user.lessons_users.where(lesson_id: object.lesson.course.lessons.ids)
  end

  def video
    Rails.application.routes.url_helpers.rails_blob_url(lesson.video) if lesson.video.attached?
  end

  def poster
    Rails.application.routes.url_helpers.rails_blob_url(lesson.poster) if lesson.poster.attached?
  end

  def tasks_user
    current_user.tasks_users.where(task_id: tasks.ids).map do |task_user|
      TasksUserSerializer.new(task_user)
    end
  end
end
