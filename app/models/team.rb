# frozen_string_literal: true

class Team < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true, length: { in: 1..100 }
  validates :description, presence: true, length: { in: 1..1000 }

  has_one_attached :poster
  has_many :users
  has_many :courses
end
