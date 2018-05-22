# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :lesson
  has_many :tasks_users, dependent: :destroy
  has_many :users, through: :tasks_users
end
