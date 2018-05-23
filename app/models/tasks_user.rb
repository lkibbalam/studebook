# frozen_string_literal: true

class TasksUser < ApplicationRecord
  belongs_to :task
  belongs_to :user
  has_many :notifications

  enum status: { undone: 0, verifying: 1, change: 2, accept: 3 }

  after_update :create_notification, on: %i[task_to_verify]
  after_update :unlock_next_lesson, on: %i[approve_task]

  private

  def create_notification
    return unless %w[change undone].include?(status_before_last_save) && verifying?
    notifications.create(user: user.mentor)
  end

  def unlock_next_lesson
    return unless %w[change verifying].include?(status_before_last_save) && accept?
    return unless user.tasks_users.where(task: task.lesson.tasks).all?(&:accept?)
    course_lessons = task.lesson.course.lessons
    lesson_index = course_lessons.index { |course_lesson| task.lesson == course_lesson }
    next_lesson = course_lessons[lesson_index + 1]
    user.lessons_users.find_by(lesson: next_lesson).update(status: :unlocked) if next_lesson
  end
end
