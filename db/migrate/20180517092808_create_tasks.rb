# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.bigint :lesson_id, index: true
      t.string :title
      t.text :description
      t.integer :position

      t.timestamps
    end
    add_index :tasks, %i[lesson_id position], unique: true
  end
end
