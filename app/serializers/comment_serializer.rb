# frozen_string_literal: true

class CommentSerializer < ActiveModel::Serializer
  attributes %i[body time state commentable_type commentable_id ancestry user user_avatar]

  def time
    object.created_at > object.updated_at ? object.created_at : object.updated_at
  end

  def state
    object.created_at > object.updated_at ? "created" : "changed"
  end

  def user_avatar
    Rails.application.routes.url_helpers.rails_blob_url(object.user.avatar) if object.user.avatar.attached?
  end
end
