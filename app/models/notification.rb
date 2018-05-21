class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :tasks_user

  enum status: { unseen: 0, seen: 1 }
end
