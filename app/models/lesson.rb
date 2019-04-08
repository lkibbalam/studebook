# frozen_string_literal: true

class Lesson < ApplicationRecord
  include Positionable
  has_one_attached :poster
  has_one_attached :video
  belongs_to :course
  has_many :lessons_users, dependent: :destroy
  has_many :students, through: :lessons_users
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :tasks, dependent: :destroy

  position_increment(scope: :course)
end
