# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.bigint :team_id, index: true
      t.bigint :author_id, index: true
      t.text :description
      t.string :title
      t.integer :status, default: 0
      t.text :slug, unique: true, index: true

      t.timestamps
    end
  end
end
