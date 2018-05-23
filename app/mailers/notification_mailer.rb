# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def notification_email(mentor, task_user)
    @task_user = task_user
    @padawan = task_user.user
    mail(to: mentor.email, subject: "Your padawan #{@padawan.first_name @padawan.last_name} waiting for task approve")
  end
end
