# frozen_string_literal: true

class TasksUser < ApplicationRecord
  belongs_to :task
  belongs_to :user
  has_many :notifications
  has_many :comments, as: :commentable, dependent: :destroy

  enum status: { undone: 0, verifying: 1, change: 2, accept: 3 }
end
