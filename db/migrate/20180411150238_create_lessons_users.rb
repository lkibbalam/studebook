class CreateLessonsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons_users do |t|
      t.bigint :student_id
      t.bigint :lesson_id
      t.integer :status
      t.integer :mark

      t.timestamps
    end
  end
end
