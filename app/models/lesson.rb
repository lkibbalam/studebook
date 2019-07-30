# frozen_string_literal: true

class Lesson < ApplicationRecord
  validates :position, uniqueness: { scope: :course,
    message: "Each course schould have lessons only with uniq position" }
  validates :title, presence: true, length: { in: 3..80 }
  validates :description, presence: true, length: { minimum: 10 }


  has_one_attached :poster
  has_one_attached :video
  belongs_to :course
  acts_as_list scope: :course
  has_many :lessons_users, dependent: :destroy
  has_many :students, through: :lessons_users
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :tasks, dependent: :destroy
end
