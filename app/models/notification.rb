# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :tasks_user

  enum status: { unseen: 0, seen: 1 }

  after_create :send_email_to_mentor

  private

  def send_email_to_mentor
    NotificationMailer.notification_email(user, tasks_user)
  end
end
