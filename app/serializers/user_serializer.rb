# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes %i[mentor_id team_id first_name last_name role phone github_url email]

  def avatar_url
    Rails.application.routes.url_helpers.rails_blob_url(object.avatar) if object.avatar.attached?
  end

  def courses
    object.courses
  end
end
