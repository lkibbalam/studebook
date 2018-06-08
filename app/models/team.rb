# frozen_string_literal: true

class Team < ApplicationRecord
  has_one_attached :poster
  has_many :users
  has_many :courses
end
