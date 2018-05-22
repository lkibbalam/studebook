# frozen_string_literal: true

class CreateLessonsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons_users do |t|
      t.bigint :student_id
      t.bigint :lesson_id
      t.integer :status, default: 0
      t.integer :mark, default: 0

      t.timestamps
    end

    add_index :lessons_users, %i[student_id lesson_id]
  end
end
