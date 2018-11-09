# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.bigint :lesson_id, index: true
      t.string :title
      t.text :description
      t.integer :order_number
      t.text :slug, unique: true, index: true

      t.timestamps
    end
  end
end
