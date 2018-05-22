# frozen_string_literal: true

class Comment < ApplicationRecord
  has_ancestry
  belongs_to :user, optional: true
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy

  default_scope { order(created_at: :desc) }
end
