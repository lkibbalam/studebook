# frozen_string_literal: true

class CoursesUser < ApplicationRecord
  belongs_to :course
  belongs_to :student, class_name: 'User', foreign_key: :student_id
  has_many :comments, as: :commentable, dependent: :destroy

  validates :student, uniqueness: { scope: :course }

  enum status: { current: 0, archived: 1 }

  after_create :create_course_lessons
  after_update :full_progress_for_archived

  private

  def create_course_lessons
    course.lessons.each { |lesson| LessonsUser.create(lesson: lesson, student: student) }
    LessonsUser.find_by(student: student, lesson: course.lessons.first).update(status: :unlocked) # unlocked first lesson of course for student
  end

  def full_progress_for_archived
    return unless saved_change_to_attribute?('status', from: 'current', to: 'archived')

    update(progress: 100)
  end
end
