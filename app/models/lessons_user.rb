# frozen_string_literal: true

class LessonsUser < ApplicationRecord
  belongs_to :lesson
  belongs_to :student, class_name: 'User', foreign_key: :student_id
  has_many :comments, as: :commentable, dependent: :destroy

  validates :student, uniqueness: { scope: :lesson }

  enum status: { unlocked: 2, done: 1, locked: 0 }

  after_create :create_tasks_users
  after_update :after_lesson_approve

  private

  def create_tasks_users
    lesson.tasks.each { |task| TasksUser.create(user: student, task: task) }
  end

  def after_lesson_approve
    return unless saved_change_to_attribute?('status', from: 'unlocked', to: 'done')

    unlock_next_lesson
    change_course_progress
  end

  def unlock_next_lesson
    course_lessons = lesson.course.lessons
    lesson_index = course_lessons.index { |course_lesson| lesson == course_lesson }
    next_lesson = course_lessons[lesson_index + 1]
    student.lessons_users.find_by(lesson: next_lesson).update(status: :unlocked) if next_lesson
  end

  def change_course_progress
    course = lesson.course
    course_user = student.courses_users.find_by(course: course)
    course_user.update(progress: course_user.progress + course.lesson_value)
  end
end
