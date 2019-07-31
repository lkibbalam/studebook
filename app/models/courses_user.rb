# frozen_string_literal: true

class CoursesUser < ApplicationRecord
  belongs_to :course
  belongs_to :student, class_name: "User", foreign_key: :student_id
  has_many :comments, as: :commentable, dependent: :destroy

  validates :student, uniqueness: { scope: :course }

  enum status: { current: 0, archived: 1 }

  after_update :full_progress!, if: :course_status_from_current_to_archived? # TODO: Cut out this hook

  private
    def course_status_from_current_to_archived?
      saved_change_to_status?(from: "current", to: "archived")
    end

    def full_progress!
      update(progress: 100)
    end
end
