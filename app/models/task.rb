# frozen_string_literal: true

class Task < ApplicationRecord
  validates :description, presence: true
  validates :title, presence: true

  belongs_to :lesson
  has_many :tasks_users, dependent: :destroy
  has_many :users, through: :tasks_users
end
