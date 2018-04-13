class Course < ApplicationRecord
  belongs_to :team
  belongs_to :author, class_name: 'User', foreign_key: :author_id, optional: true # drop optional:true when added user
  has_many :courses_users, dependent: :destroy
  has_many :students, through: :courses_users
  has_many :lessons
  has_many :comments, as: :commentable, dependent: :destroy
end
