class LessonsUser < ApplicationRecord
  belongs_to :lesson
  belongs_to :student, class_name: 'User', foreign_key: :student_id

  enum status: { done: 1, undone: 0 }
end
