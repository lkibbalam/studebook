# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes %i[mentor_id team_id first_name last_name role phone github_url email avatar]

  def avatar
    Rails.application.routes.url_helpers.rails_blob_url(object.avatar) if object.avatar.attached?
  end
end
