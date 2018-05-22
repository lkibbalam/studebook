# frozen_string_literal: true

class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :title
      t.string :img
      t.text :description

      t.timestamps
    end
  end
end
