# frozen_string_literal: true

class CreateCoursesUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :courses_users do |t|
      t.bigint :student_id
      t.bigint :course_id
      t.integer :status, default: 0
      t.integer :mark, default: 0
      t.integer :progress, default: 0 # change to float when next migrate, adds between 0 and 100

      t.timestamps
    end
    add_index :courses_users, %i[course_id student_id]
  end
end
