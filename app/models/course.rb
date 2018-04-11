class Course < ApplicationRecord
  belongs_to :team
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :courses_users, dependent: :destroy
  has_many :students, through: :courses_users
end
