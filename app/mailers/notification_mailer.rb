# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def notification_email(mentor, padawan, task)
    @task = task
    mail(to: mentor.email, subject: "Your padawan #{padawan.first_name padawan.last_name} waiting for task approve")
  end
end
