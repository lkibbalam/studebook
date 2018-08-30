# frozen_string_literal: true

class LessonsUserSerializer < ActiveModel::Serializer
  attributes %i[status lesson tasks course lessons student_id video poster tasks_user]

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
    course.lessons.each do |lesson|
      lesson_user = object.student.lessons_users.find_by(lesson: lesson)
      lesson.attributes.merge(lesson_user)
    end
  end

  def video
    Rails.application.routes.url_helpers.rails_blob_url(lesson.video) if lesson.video.attached?
  end

  def poster
    Rails.application.routes.url_helpers.rails_blob_url(lesson.poster) if lesson.poster.attached?
  end

  def tasks_user
    TasksUser.where(task: tasks, user: object.student)
  end
end
