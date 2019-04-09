# frozen_string_literal: true

class Task < ApplicationRecord
  include Positionable

  validates :description, presence: true
  validates :title, presence: true
  validates :position, uniqueness: { scope: :lesson }

  belongs_to :lesson
  has_many :tasks_users, dependent: :destroy
  has_many :users, through: :tasks_users

  position_increment(scope: :lesson)
end
