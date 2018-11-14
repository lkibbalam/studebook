# frozen_string_literal: true

class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :title
      t.text :description
      t.text :slug

      t.timestamps
    end

    add_index :teams, :slug, unique: true
  end
end
