# frozen_string_literal: true

class TeamSerializer < ActiveModel::Serializer
  attributes %i[title description]

  def poster
    Rails.application.routes.url_helpers.rails_blob_url(object.poster) if object.poster.attached?
  end
end
