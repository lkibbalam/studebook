# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :tasks_user

  enum status: { unseen: 0, seen: 1 }

  after_create :send_email_to_mentor, :send_email_to_student

  private

  def send_email_to_mentor
    NotificationMailer.notification_email(user, tasks_user) unless user == tasks_user.user
  end

  def send_email_to_student
    NotificationMailer.notification_email(user, tasks_user) if user == tasks_user.user
  end
end
