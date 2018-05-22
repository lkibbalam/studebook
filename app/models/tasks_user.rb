# frozen_string_literal: true

class TasksUser < ApplicationRecord
  belongs_to :task
  belongs_to :user
  has_many :notifications

  enum status: { undone: 0, verifying: 1, change: 2, accept: 3 }

  after_update :create_notification, on: %i[task_to_verify]
  after_update :open_next_lesson, on: %i[approve_task]

  private

  def create_notification
    # return unless saved_change_to_attribute?('status', from: %w[undone change], to: 'verifying')
    # i cant to pass few words to from: **option, only one string 'undone' or 'change' but i want
    notifications.create(user: user.mentor)
  end

  def open_next_lesson
    return unless TasksUser.where(user: user).all? { |task| task.status.accept? }
    # finish method
  end
end
