# frozen_string_literal: true

class Team < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_one_attached :poster
  has_many :users
  has_many :courses
end
