# frozen_string_literal: true

class User < ApplicationRecord
  paginates_per 25

  validates_with EmailValidator
  validates :email, uniqueness: true

  has_secure_password
  has_one_attached :avatar
  has_and_belongs_to_many :mentors, join_table: :mentorships,
                                    class_name: "User",
                                    foreign_key: :mentor_id,
                                    association_foreign_key: :padawan_id
  has_and_belongs_to_many :padawans, join_table: :mentorships,
                                     class_name: "User",
                                     foreign_key: :padawan_id,
                                     association_foreign_key: :mentor_id

  belongs_to :team, optional: true
  has_many :own_courses, class_name: "Course", foreign_key: :author_id
  has_many :comments, class_name: "Comment", foreign_key: :user_id
  has_many :courses_users, dependent: :destroy, foreign_key: :student_id
  has_many :courses, through: :courses_users
  has_many :lessons_users, dependent: :destroy, foreign_key: :student_id
  has_many :lessons, through: :lessons_users
  has_many :tasks_users, dependent: :destroy
  has_many :tasks, through: :tasks_users
  has_many :notifications

  enum role: { admin: 5, leader: 4, moder: 3, staff: 2, student: 1 }
  enum status: { active: 0, inactive: 1 }

  def mentor_of?(padawan)
    in?(padawan.mentors)
  end

  def done_lesson(lesson)
    lesson_user = lessons_users.find_by(lesson: lesson)
    return unless lesson_user
    lesson_user.done! if lesson_user.unlocked?
    courses_users.find_by(course: lesson.course).update_progress
  end
end
