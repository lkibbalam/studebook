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
    course.lessons.each { |lesson| student.lessons_users.create(lesson: lesson) }
    student.lessons_users.find_by(lesson: course.lessons.order('id').first).update(status: :unlocked)
  end

  def full_progress_for_archived
    return unless saved_change_to_attribute?('status', from: 'current', to: 'archived')

    update(progress: 100)
  end
end
