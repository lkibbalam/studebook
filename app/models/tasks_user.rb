# frozen_string_literal: true

class TasksUser < ApplicationRecord
  belongs_to :task
  belongs_to :user
  has_many :notifications
  has_many :comments, as: :commentable, dependent: :destroy

  enum status: { undone: 0, verifying: 1, change: 2, accept: 3 }

  after_update :create_notification_to_mentor
  after_update :create_notification_to_student
  after_update :unlock_next_lesson

  private

  def create_notification_to_mentor
    return unless %w[change undone].include?(status_before_last_save) && verifying?

    notifications.create(user: user.mentor)
  end

  def create_notification_to_student
    return unless (change? || accept?) && status_before_last_save == 'verifying'

    notifications.create(user: user)
  end

  def unlock_next_lesson
    return unless %w[change verifying].include?(status_before_last_save) && accept?
    return unless user.tasks_users.where(task: task.lesson.tasks).all?(&:accept?) # TODO: rewrite this string

    course_lessons = task.lesson.course.lessons
    lesson_index = course_lessons.index { |course_lesson| task.lesson == course_lesson }
    done_lesson(course_lessons[lesson_index])
    next_lesson = course_lessons[lesson_index + 1]
    user.lessons_users.find_by(lesson: next_lesson).update(status: :unlocked) if next_lesson
  end

  def done_lesson(lesson)
    user.lessons_users.find_by(lesson: lesson).update(status: :done) if lesson
  end
end
