# frozen_string_literal: true

class Task < ApplicationRecord
  validates :title, presence: true, length: { in: 3..80 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :position, uniqueness: { scope: :lesson,
    message: "Each lesson schould have tasks only with uniq position" }

  belongs_to :lesson
  acts_as_list scope: :lesson
  has_many :tasks_users, dependent: :destroy
  has_many :users, through: :tasks_users
end
