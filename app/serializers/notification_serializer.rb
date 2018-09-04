# frozen_string_literal: true

class NotificationSerializer < ActiveModel::Serializer
  attributes %i[status tasks_user student task created_at user_avatar lessons_user mentor mentor_avatar lesson course]

  def tasks_user
    object.tasks_user
  end

  def mentor
    student.mentor
  end

  def student
    tasks_user.user
  end

  def task
    tasks_user.task
  end

  def lesson
    task.lesson
  end

  def course
    lesson.course
  end

  def lessons_user
    student.lessons_users.find_by(lesson: task.lesson)
  end

  def mentor_avatar
    Rails.application.routes.url_helpers.rails_blob_url(mentor.avatar) if mentor.avatar.attached?
  end

  def user_avatar
    Rails.application.routes.url_helpers.rails_blob_url(student.avatar) if student.avatar.attached?
  end
end
