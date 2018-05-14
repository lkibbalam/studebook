class Video < ApplicationRecord
  belongs_to :lesson
  belongs_to :course
end
