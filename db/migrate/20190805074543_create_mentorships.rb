# frozen_string_literal: true

class CreateMentorships < ActiveRecord::Migration[5.2]
  def change
    create_table :mentorships do |t|
      t.references :mentor, foreign_key: { to_table: :users }
      t.references :padawan, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
