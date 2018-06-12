# frozen_string_literal: true

class Course < ApplicationRecord
  has_one_attached :poster
  belongs_to :team, optional: true
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :courses_users, dependent: :destroy
  has_many :students, through: :courses_users
  has_many :lessons
  has_many :comments, as: :commentable, dependent: :destroy

  def lesson_value
    (100 / lessons.count.to_f).round(2) # 100 mean 100%, full bar of progress
  end
end
