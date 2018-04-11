class CreateCoursesUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :courses_users do |t|
      t.bigint :student_id, index: true
      t.bigint :course_id, index: true
      t.text :opinion
      t.string :chat

      t.timestamps
    end
    add_index :courses_users, %i[course_id student_id]
  end
end
