# frozen_string_literal: true

class TasksUser < ApplicationRecord
  belongs_to :task
  belongs_to :user
  has_many :notifications
  has_many :comments, as: :commentable, dependent: :destroy

  enum status: { undone: 0, verifying: 1, change: 2, accept: 3 }

  # ActiveRecord::Base.transaction do
  # after_update :unlock_next_lesson, if: :lesson_accept? && :tasks_accept?
  # end

  private

  def lesson_accept?
    %w[change verifying].include?(status_before_last_save) && accept?
  end

  def tasks_accept?
    user.tasks_users.where(task: task.lesson.tasks).all?(&:accept?)
  end

  def unlock_next_lesson
    # Refactor this, with order number of each lesson
    course_lessons = task.lesson.course.lessons
    lesson_index = course_lessons.index(task.lesson)
    lesson_done!(course_lessons[lesson_index])
    next_lesson = course_lessons[lesson_index + 1]
    lesson_user = user.lessons_users.find_by(lesson: next_lesson)
    lesson_user.update!(status: :unlocked) if lesson_user&.locked?
  end

  def lesson_done!(lesson)
    lesson_user = user.lessons_users.find_by(lesson: lesson)
    lesson_user.update!(status: :done) if lesson_user&.unlocked?
  end
end
