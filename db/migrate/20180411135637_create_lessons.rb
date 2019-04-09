# frozen_string_literal: true

class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.bigint :course_id, index: true
      t.text :description
      t.text :material
      t.string :title
      t.integer :position

      t.timestamps
    end
    add_index :lessons, %i[course_id position], unique: true
  end
end
