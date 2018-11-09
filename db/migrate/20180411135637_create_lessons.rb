# frozen_string_literal: true

class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.bigint :course_id, index: true
      t.text :description
      t.text :material
      t.string :title
      t.integer :order_number
      t.text :slug, unique: true, index: true

      t.timestamps
    end
  end
end
