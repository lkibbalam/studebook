# frozen_string_literal: true

class LessonsUser < ApplicationRecord
  belongs_to :lesson
  belongs_to :student, class_name: "User", foreign_key: :student_id
  has_many :comments, as: :commentable, dependent: :destroy

  validates :student, uniqueness: { scope: :lesson }

  enum status: { unlocked: 2, done: 1, locked: 0 }
end
