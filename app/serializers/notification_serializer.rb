# frozen_string_literal: true

class NotificationSerializer < ActiveModel::Serializer
  attributes %i[status tasks_user student task created_at user_avatar]

  def tasks_user
    object.tasks_user
  end

  def student
    tasks_user.user
  end

  def task
    tasks_user.task
  end

  def user_avatar
    Rails.application.routes.url_helpers.rails_blob_url(student.avatar) if student.avatar.attached?
  end
end
