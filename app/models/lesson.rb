# frozen_string_literal: true

class Lesson < ApplicationRecord
  validates :title, presence: true, length: { in: 1..30 }
  validates :description, presence: true, length: { minimum: 5 }
  validates :position, uniqueness: { scope: :course,
    message: "Each course schould have lessons only with uniq position" }


  has_one_attached :poster
  has_one_attached :video
  belongs_to :course
  acts_as_list scope: :course
  has_many :lessons_users, dependent: :destroy
  has_many :students, through: :lessons_users
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :tasks_users, through: :tasks

  def accepted_for?(user)
    tasks_users.where(user: user).all?(&:accept?)
  end

  def next
    course.lessons.find_by(position: position + 1)
  end
end
