class User < ApplicationRecord
  belongs_to :team
  belongs_to :mentor, class_name: 'User', foreign_key: :mentor_id, optional: true
  has_many :own_courses, class_name: 'Course', foreign_key: :author_id
  has_many :wards, class_name: 'User', foreign_key: :id
  has_many :courses_users, dependent: :destroy, foreign_key: :student_id
  has_many :courses, through: :courses_users

  enum role: { admin: 5, leader: 4, moder: 3, staff: 2, student: 1 }
end
