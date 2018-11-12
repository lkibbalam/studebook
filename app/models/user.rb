# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar
  belongs_to :team, optional: true
  belongs_to :mentor, class_name: 'User', foreign_key: :mentor_id, optional: true
  has_many :own_courses, class_name: 'Course', foreign_key: :author_id
  has_many :padawans, class_name: 'User', foreign_key: :mentor_id
  has_many :comments, class_name: 'Comment', foreign_key: :user_id
  has_many :courses_users, dependent: :destroy, foreign_key: :student_id
  has_many :courses, through: :courses_users
  has_many :lessons_users, dependent: :destroy, foreign_key: :student_id
  has_many :lessons, through: :lessons_users
  has_many :tasks_users, dependent: :destroy
  has_many :tasks, through: :tasks_users
  has_many :notifications

  enum role: { admin: 5, leader: 4, moder: 3, staff: 2, student: 1 }
  enum status: { active: 0, inactive: 1 }
end
