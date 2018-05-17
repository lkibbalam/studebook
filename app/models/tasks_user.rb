class TasksUser < ApplicationRecord
  belongs_to :task
  belongs_to :user

  enum status: { undone: 0, verifying: 1, change: 2, accept: 3 }
end
