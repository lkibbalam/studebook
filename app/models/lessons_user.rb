# frozen_string_literal: true

class LessonsUser < ApplicationRecord
  belongs_to :lesson
  belongs_to :student, class_name: 'User', foreign_key: :student_id
  has_many :comments, as: :commentable, dependent: :destroy

  validates :student, uniqueness: { scope: :lesson }

  enum status: { unlocked: 2, done: 1, locked: 0 }

  # ActiveRecord::Base.transaction do
  #   after_update :unlock_next_lesson, :change_course_progress, if: :lesson_approved?
  # end

  private

  def lesson_approved?
    saved_change_to_status?(from: 'unlocked', to: 'done')
  end

  def unlock_next_lesson
    course_lessons = lesson.course.lessons
    lesson_index = course_lessons.index { |course_lesson| lesson == course_lesson }
    next_lesson = course_lessons[lesson_index + 1]
    lesson_user = student.lessons_users.find_by(lesson: next_lesson)
    lesson_user.update(status: :unlocked) if lesson_user&.locked?
  end

  def change_course_progress
    course = lesson.course
    course_user = student.courses_users.find_by(course: course)
    course_user.update(progress: course_user.progress + course.lesson_value)
  end
end
