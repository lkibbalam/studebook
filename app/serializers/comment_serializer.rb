# frozen_string_literal: true

class CommentSerializer < ActiveModel::Serializer
  attributes %i[body time state commentable_type commentable_id ancestry user]

  def time
    object.created_at > object.updated_at ? object.created_at : object.updated_at
  end

  def state
    object.created_at > object.updated_at ? 'created' : 'changed'
  end
end
