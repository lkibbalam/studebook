class User < ApplicationRecord
  belongs_to :team
  enum role: { admin: 5, leader: 4, moder: 3, staff: 2, student: 1 }
end
