class TasksUser < ApplicationRecord
  belongs_to :task
  belongs_to :user
  has_one :notification

  enum status: { undone: 0, verifying: 1, change: 2, accept: 3 }

  after_update :create_notification, on: %i[task_to_verify]

  private

  def create_notification
    return unless saved_change_to_attribute?('status', from: %w[undone change], to: 'verifying')
    Notification.create(user: user.mentor, tasks_user: self)
  end
end
