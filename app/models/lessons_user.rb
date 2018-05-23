# frozen_string_literal: true

class LessonsUser < ApplicationRecord
  belongs_to :lesson
  belongs_to :student, class_name: 'User', foreign_key: :student_id
  has_many :comments, as: :commentable, dependent: :destroy

  validates :student, uniqueness: { scope: :lesson }

  enum status: { unlocked: 2, done: 1, locked: 0 }

  after_create :create_tasks_users
  after_update :unlock_next_lesson, on: %i[approve_lesson]

  private

  def create_tasks_users
    lesson.tasks.each { |task| TasksUser.create(user: student, task: task) }
    # TODO: test
  end

  def unlock_next_lesson
    return unless saved_change_to_attribute?('status', from: 'unlocked', to: 'done')
    course_lessons = lesson.course.lessons
    lesson_index = course_lessons.index { |course_lesson| lesson == course_lesson }
    next_lesson = course_lessons[lesson_index + 1]
    student.lessons_users.find_by(lesson: next_lesson).lesson_user.update(status: :unlocked) if next_lesson
    # TODO: tests, maybe refactor faster simpler way!
  end
end
