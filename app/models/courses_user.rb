# frozen_string_literal: true

class CoursesUser < ApplicationRecord
  belongs_to :course
  belongs_to :student, class_name: 'User', foreign_key: :student_id
  has_many :comments, as: :commentable, dependent: :destroy

  validates :student, uniqueness: { scope: :course }

  enum status: { current: 0, archived: 1 }

  def update_progress!
    lessons_user = student.lessons_users.where(lesson: course.lessons)
    done_lessons_user_count = lessons_user.where(status: :done).count
    return update(progress: 100, status: :archived) if lessons_user.size == done_lessons_user_count

    update(progress: 100 / lessons_user.size * done_lessons_user_count)
  end
end
